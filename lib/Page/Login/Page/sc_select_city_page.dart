import 'dart:convert';
import 'dart:developer';

import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:smartcommunity/Constants/sc_colors.dart';
import 'package:smartcommunity/Constants/sc_fonts.dart';
import 'package:smartcommunity/Page/Login/GetXController/sc_select_city_controller.dart';
import 'package:smartcommunity/Page/Login/View/SelectCity/sc_city_listview.dart';
import 'package:smartcommunity/Page/Login/View/SelectCity/sc_city_search_result_listview.dart';

import '../../../Constants/sc_enum.dart';
import '../../../Utils/Router/sc_router_helper.dart';
import '../../../Utils/sc_location_utils.dart';
import '../../../Utils/sc_utils.dart';
import '../GetXController/sc_search_city_controller.dart';
import '../Model/SelectCommunity/sc_location_model.dart';
import '../Model/sc_city_model.dart';
import '../View/SelectCity/sc_city_search_header.dart';

class SCSelectCityPage extends StatefulWidget {
  @override
  SCSelectCityState createState() => SCSelectCityState();
}

class SCSelectCityState extends State<SCSelectCityPage> with WidgetsBindingObserver {
  List<SCCityModel> cityList = [];

  String cityCode = '';
  String locationCity = '';
  SCLocationStatus locationStatus = SCLocationStatus.failure;

  SCSelectCityController state = Get.put(SCSelectCityController());
  SCSearchCityController searchState = Get.put(SCSearchCityController());


  @override
  void initState() {
    super.initState();
    var params = Get.arguments;
    log('上个页面传过来的参数:$params');
    cityCode = params['cityCode'];
    locationCity = params['locationCity'];
    locationStatus = params['locationStatus'];
    loadData();
    WidgetsBinding.instance.addObserver(this);
  }

  /// 由后台返回主屏幕 刷新数据
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      if (searchState.locationCity == '') {
        /// 重新定位
        startLocation();
      }
    }
  }

  @override
  dispose() {
    super.dispose();
    /// 销毁观察者
    WidgetsBinding.instance.removeObserver(this);
  }

  void loadData() async {
    //加载城市列表
    rootBundle.loadString('json/city.json').then((value) {
      cityList.clear();
      Map countyMap = json.decode(value);
      List list = countyMap['china'];
      for (var v in list) {
        cityList.add(SCCityModel.fromJson(v));
      }
      _handleList(cityList);
    });
  }

  void _handleList(List<SCCityModel> list) {
    if (list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp('[A-Z]').hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = '#';
      }
    }
    // A-Z sort.
    SuspensionUtil.sortListBySuspensionTag(list);

    // show sus tag.
    SuspensionUtil.setShowSuspensionStatus(cityList);

    state.updateCityList(list: cityList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: titleItem(),
        backgroundColor: SCColors.color_FFFFFF,
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: Container(
        color: SCColors.color_FFFFFF,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            header(),
            Expanded(
              child: cityListView(),
            )
          ],
        ),
      ),
    );
  }

  /// header
  Widget header() {
    return GetBuilder<SCSearchCityController>(builder: (state){
      return SCCitySearchHeader(
        locationStatus: locationStatus,
        locationCity: locationCity,
        isShowCancel: state.isShowCancel,
        cancelAction: (){
        cancelAction();
      }, valueChangedAction: (String value) {
        valueChangedAction(value);
      },);
    });
  }

  /// title
  Widget titleItem() {
    return const Text('选择城市', style: TextStyle(
        fontSize: SCFonts.f16,
        fontWeight: FontWeight.bold,
        color: SCColors.color_1B1C33
    ),);
  }

  /// 城市列表
  Widget cityListView() {
    return GetBuilder<SCSelectCityController>(builder: (state){
      if (state.isShowResult) {
        return SCCitySearchResultListView(cityList: state.searchList,
          selectCityHandler: (SCCityModel model) {
            state.updateSelectCity(model: model);
            var params = {
              'selectCity' : model.name,
              'selectCityCode' : model.cityCode,
            };
            log('搜索城市结果cell点击返回：$params');
            SCRouterHelper.back(params);
        },);
      } else {
        return SCCityListView(cityList: state.cityList, selectCityHandler: (SCCityModel model) {
          state.updateSelectCity(model: model);
          var params = {
            'selectCity' : model.name,
            'selectCityCode' : model.cityCode,
          };
          log('城市列表cell点击返回：$params');
          SCRouterHelper.back(params);
        });
      }
    });
  }

  /// 取消
  cancelAction() {
    SCSelectCityController state = Get.find<SCSelectCityController>();
    state.updateSearchResult(status: false);
    state.updateSearchList(list: []);

    SCSearchCityController searchState = Get.find<SCSearchCityController>();
    searchState.updateCancelButtonStatus(status: false);
  }

  /// 文本框内容改变
  valueChangedAction(String value) {
    SCSelectCityController state = Get.find<SCSelectCityController>();

    if (value.isNotEmpty) {
      List<SCCityModel> list = [];
      if (state.cityList != null) {
        for(int i=0; i < state.cityList!.length; i++) {
          SCCityModel cityModel = state.cityList![i];
          String name = cityModel.name;
          // String namePinYin = cityModel?.namePinyin ?? '';
          // String tagIndex = cityModel?.tagIndex ?? '';
          if (name.contains(value)) {
            list.add(cityModel);
          }
        }
        state.updateSearchList(list: list);
      }
    } else {
      state.updateSearchList(list: []);
    }
  }

  /// 定位
  startLocation() async{
    LocationPermission permission = await SCLocationUtils.requestPermission();
    SCSearchCityController searchState = Get.find<SCSearchCityController>();
    searchState.updateLocationPermission(permission: permission);
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      /// 定位被拒绝，无权限
    } else if(permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      /// 已获取定位权限
      Position position = await SCLocationUtils.location();
      reGeoCode(position: position);
    } else {
      /// 权限无法确定
    }
  }

  /// 逆地理编码
  reGeoCode({required Position position}) async{
    await SCLocationUtils.reGeoCode(position: position, success: (value){
      SCLocationModel model = value;
      log('城市:${model.addressComponent?.city ?? ''}');
      SCSearchCityController searchState = Get.find<SCSearchCityController>();
      searchState.updateLocationCity(
          city: model.addressComponent?.city ?? '',
          code: model.addressComponent?.citycode ?? '',
          lati: position.latitude,
          long: position.longitude);
    }, failure: (value){

    });
  }

}
