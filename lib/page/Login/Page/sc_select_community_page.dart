
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/constants/sc_fonts.dart';
import 'package:smartcommunity/utils/sc_location_utils.dart';

import '../../../constants/sc_asset.dart';
import '../../../constants/sc_colors.dart';
import '../../../utils/Router/sc_router_helper.dart';
import '../GetXController/sc_search_community_controller.dart';
import '../GetXController/sc_select_community_controller.dart';
import '../Model/SelectCommunity/sc_location_model.dart';
import '../Model/sc_community_model.dart';
import '../View/SelectCommunity/sc_community_empty_item.dart';
import '../View/SelectCommunity/sc_community_header.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smartcommunity/page/Login/View/SelectCommunity/sc_community_search_result_listview.dart';
import 'package:smartcommunity/page/Login/View/SelectCommunity/sc_community_listView.dart';

/// 选择园区

class SCSelectCommunityPage extends StatefulWidget {

  const SCSelectCommunityPage({Key? key}) : super(key: key);

  @override
  SCSelectCommunityState createState() => SCSelectCommunityState();
}

class SCSelectCommunityState extends State<SCSelectCommunityPage> with WidgetsBindingObserver {

  SCSearchCommunityController searchState = Get.put(SCSearchCommunityController());

  SCSelectCommunityController selectState = Get.put(SCSelectCommunityController());

  @override
  initState() {
    super.initState();
    startLocation();
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
              child: communityListView(),
            )
          ],
        ),
      ),
    );
  }

  /// header
  Widget header() {
    return GetBuilder<SCSearchCommunityController>(builder: (state){
      return SCCommunityHeader(
        locationStatus: state.locationStatus,
        locationCity: state.locationCity,
        selectCity: state.selectCity,
        node: state.node,
        isShowCancel: state.isShowCancel,
        cancelAction: (){
        cancelAction();
      }, valueChangedAction: (String value) {
        valueChangedAction(value);
      },selectCityAction: () {
        openSelectCityPage();
      },);
    });
  }

  /// title
  Widget titleItem() {
    return const Text('选择项目', style: TextStyle(
        fontSize: SCFonts.f16,
        fontWeight: FontWeight.bold,
        color: SCColors.color_1B1C33
    ),);
  }

  /// 社区列表
  Widget communityListView() {
    return GetBuilder<SCSelectCommunityController>(builder: (state){
      if (state.isShowResult) {
        if (state.searchList!.isNotEmpty) {
          return SCCommunitySearchResultListView(communityList: state.searchList, selectCommunityHandler: (SCCommunityModel model) {
            state.updateSelectCommunity(model: model);
          },);
        } else {
          return emptyView();
        }
      } else {
        if (state.communityList!.isNotEmpty) {
          return SCCommunityListView(communityList: state.communityList,);
        } else {
          return emptyView();
        }
      }
    });
  }

  Widget emptyView() {
    /// 数据加载失败就显示底部重新获取按钮
    return SCCommunityEmptyItem(
      imageName: SCAsset.iconCommunityNoData,
      content: '暂无可选项目',
      buttonTitle: '重新获取',
      showButton: false,
      btnTapAction: () {
        /// 重新加载数据

      },);
  }

  /// 取消
  cancelAction() {
    SCSelectCommunityController state = Get.find<SCSelectCommunityController>();
    state.updateSearchResult(status: false);
    state.updateSearchList(list: []);

    SCSearchCommunityController searchState = Get.find<SCSearchCommunityController>();
    searchState.updateCancelButtonStatus(status: false);
  }

  /// 文本框内容改变
  valueChangedAction(String value) {
    SCSelectCommunityController state = Get.find<SCSelectCommunityController>();

    if (value.isNotEmpty) {
      List<SCCommunityModel> list = [];
      if (state.communityList != null) {
        for(int i = 0; i < state.communityList!.length; i++) {
          SCCommunityModel communityModel = state.communityList![i];
          String name = communityModel?.name ?? '';
          if (name.contains(value)) {
            list.add(communityModel);
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
    SCSearchCommunityController searchState = Get.find<SCSearchCommunityController>();
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
      SCSearchCommunityController searchState = Get.find<SCSearchCommunityController>();
      searchState.updateLocationCity(city: model.addressComponent?.city ?? '');
      searchState.updateLocationCityCode(code: model.addressComponent?.citycode ?? '');
    }, failure: (value){

    });
  }

  ///  选择城市
  openSelectCityPage() async{
    SCSearchCommunityController searchState = Get.find<SCSearchCommunityController>();
    var params = {
      'locationCity' : searchState.locationCity,
      'locationStatus' : searchState.locationStatus,
      'cityCode' : searchState.cityCode,
    };
    var backParams = await SCRouterHelper.codePage(9002, params);
    log('返回的参数:$backParams');

    String city = backParams['selectCity'] ?? '';
    String cityCode = backParams['selectCityCode'] ?? '';

    searchState.updateSelectCity(city: city ?? '');
    searchState.updateSelectCityCode(code: cityCode ?? '');

  }
}

