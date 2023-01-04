import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_enum.dart';
import 'package:smartcommunity/Skin/View/sc_custom_scaffold.dart';
import 'package:smartcommunity/Utils/Router/sc_router_path.dart';
import 'package:smartcommunity/Utils/sc_location_utils.dart';

import '../../../Constants/sc_asset.dart';
import '../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../Utils/Router/sc_router_helper.dart';
import '../GetXController/sc_search_community_controller.dart';
import '../GetXController/sc_select_community_controller.dart';
import '../Model/SelectCommunity/sc_location_model.dart';
import '../Model/sc_community_model.dart';
import '../View/SelectCommunity/sc_community_empty_item.dart';
import '../View/SelectCommunity/sc_community_header.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smartcommunity/Page/Login/View/SelectCommunity/sc_community_search_result_listview.dart';
import 'package:smartcommunity/Page/Login/View/SelectCommunity/sc_community_listView.dart';

/// 选择园区

class SCSelectCommunityPage extends StatefulWidget {
  const SCSelectCommunityPage({Key? key}) : super(key: key);

  @override
  SCSelectCommunityState createState() => SCSelectCommunityState();
}

class SCSelectCommunityState extends State<SCSelectCommunityPage>
    with WidgetsBindingObserver {

  // 默认是登录成功后直接进来选则房号
  SCSelectHouseLogicType type = SCSelectHouseLogicType.login;

  late SCSelectCommunityController selectState;

  late SCSearchCommunityController searchState;

  String tag = '';

  @override
  initState() {
    super.initState();
    String pageName = (SCSelectCommunityPage).toString();
    tag = SCScaffoldManager.instance.getXControllerTag(pageName);
    searchState = Get.put(SCSearchCommunityController(), tag: tag);
    searchState.tag = tag;
    searchState.pageName = pageName;

    selectState = Get.put(SCSelectCommunityController(), tag: tag);
    selectState.tag = tag;
    selectState.pageName = pageName;
    selectState.updateSearchState();

    startLocation();
    WidgetsBinding.instance.addObserver(this);

    var arguments = Get.arguments;
    if (arguments != null) {
      type = arguments['type'];
    }
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
    SCScaffoldManager.instance.deleteGetXControllerTag(selectState.pageName, selectState.tag);
    SCScaffoldManager.instance.deleteGetXControllerTag(searchState.pageName, searchState.tag);
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "选择项目",
        centerTitle: true,
        elevation: 0,
        actions: [skipItem()],
        body: body());
  }

  Widget body() {
    return Container(
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
    );
  }

  /// header
  Widget header() {
    return GetBuilder<SCSearchCommunityController>(
        init: searchState,
        tag: tag,
        builder: (value) {
      return SCCommunityHeader(
        selectState: selectState,
        searchState: searchState,
        locationStatus: searchState.locationStatus,
        locationCity: searchState.locationCity,
        selectCity: searchState.selectCity,
        node: searchState.node,
        isShowCancel: searchState.isShowCancel,
        cancelAction: () {
          cancelAction();
        },
        searchAction: (String value) {
          searchAction(value);
        },
        selectCityAction: () {
          openSelectCityPage();
        },
      );
    });
  }

  /// 跳过
  Widget skipItem() {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      minSize: 60.0,
      child: const Text(
        '跳过',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.w500,
          color: SCColors.color_1B1D33,
        ),
      ),
      onPressed: () {
        SCRouterHelper.pathOffAllPage(SCRouterPath.tabPath, null);
      });
  }

  /// 社区列表
  Widget communityListView() {
    return GetBuilder<SCSelectCommunityController>(
        init: selectState,
        tag: tag,
        builder: (value) {
      if (selectState.isShowResult) {
        return SCCommunitySearchResultListView(
          selectState: selectState,
          searchState: searchState,
          type: type,
          communityList: selectState.searchList,
          selectCommunityHandler: (SCCommunityModel model) {
            selectState.updateSelectCommunity(model: model);
        });
      } else {
        return SCCommunityListView(
          selectState: selectState,
          searchState: searchState,
          type: type,
          communityList: selectState.communityList,
        );
      }
    });
  }

  /// 取消
  cancelAction() {
    selectState.updateSearchResult(status: false);
    selectState.updateSearchList(list: []);

    searchState.updateCancelButtonStatus(status: false);
  }

  /// 搜索
  searchAction(String value) {
    selectState.updateKeyword(value);
    /// 请求接口搜索
    selectState.loadSearchResultData(isLoadMore: false);

    // 本地搜索
    // if (value.isNotEmpty) {
    //   List<SCCommunityModel> list = [];
    //   if (state.communityList.isNotEmpty) {
    //     for (int i = 0; i < state.communityList.length; i++) {
    //       SCCommunityModel communityModel = state.communityList[i];
    //       String name = communityModel?.name ?? '';
    //       if (name.contains(value)) {
    //         list.add(communityModel);
    //       }
    //     }
    //     state.updateSearchList(list: list);
    //   }
    // } else {
    //   state.updateSearchList(list: []);
    // }
  }

  /// 定位
  startLocation() async {
    LocationPermission permission = await SCLocationUtils.requestPermission();
    searchState.updateLocationPermission(permission: permission);
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      /// 定位被拒绝，无权限
    } else if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
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
      searchState.updateLocationCity(
        city: model.addressComponent?.city ?? '',
        code: model.addressComponent?.citycode ?? '',
        lati: position.latitude,
        long: position.longitude
      );
      loadData();
    }, failure: (value){

    });
  }

  ///  选择城市
  openSelectCityPage() async {
    var params = {
      'locationCity': searchState.locationCity,
      'locationStatus': searchState.locationStatus,
      'cityCode': searchState.cityCode,
    };
    var backParams = await SCRouterHelper.pathPage(SCRouterPath.selectCityPath, params);

    /// 当在搜索结果页面输入时点击选择城市跳转要收起键盘，调用cancelAction方法
    cancelAction();

    log('返回的参数:$backParams');
    String city = backParams['selectCity'] ?? '';
    String cityCode = backParams['selectCityCode'] ?? '';
    searchState.updateSelectCity(city: city, code: cityCode);
    loadData();
  }

  /// 加载数据
  loadData() {
    if (selectState.communityList.isEmpty) {
      selectState.loadCommunityData();
    } else {
      selectState.refreshController.callRefresh();
    }
  }

}
