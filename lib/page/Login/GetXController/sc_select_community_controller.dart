
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_search_community_controller.dart';

import '../../../network/sc_http_manager.dart';
import '../../../network/sc_url.dart';
import '../../../utils/Toast/sc_toast.dart';
import '../Model/sc_community_model.dart';

/// 选择社区-Controller

class SCSelectCommunityController extends GetxController {
  /// 社区列表数据源
  List<SCCommunityModel> communityList = [];

  /// 搜索的数据源
  List<SCCommunityModel> searchList = [];

  /// 是否搜索结果页面
  bool isShowResult = false;

  /// 选择的社区
  SCCommunityModel? selectCommunityModel;

  @override
  onInit() {
    super.onInit();

    /// 测试数据
    var testList = [
      {'name':'慧享生活园区','id':1, 'address':'文一西路767号','distance':'<300m'},
      {'name':'绿城园区','id':2, 'address':'文一西路777号','distance':'<500m'},
      {'name':'蒋村地铁','id':3, 'address':'文二路11号','distance':'<600m>'},
      {'name':'天堂软件园','id':4, 'address':'北京路88号','distance':'<1km>'},
      {'name':'蒋村商务中心','id':5, 'address':'文涛路99号','distance':'<2km'}
    ];
    //communityList = testList.map((e) => SCCommunityModel.fromJson(e)).toList();

  }

  /// 更新社区列表数据源
  updateCommunityList({required List<SCCommunityModel> list}) {
    communityList = list;
    update();
  }

  /// 更新搜索的数据源
  updateSearchList({required List<SCCommunityModel> list}) {
    searchList = list;
    update();
  }

  /// 选择的社区
  updateSelectCommunity({required SCCommunityModel model}) {
    selectCommunityModel = model;
    isShowResult = false;
    update();
  }

  /// 是否正在搜索
  updateSearchResult({bool status = false}) {
    isShowResult = status;
    update();
  }

  loadCommunityData() {
    SCSearchCommunityController searchState = Get.find<SCSearchCommunityController>();

    if (searchState.selectCity == '' && searchState.latitude == 0.0) {
      /// 没定位也没选择的城市，页面不请求数据
    } else {
      if (searchState.selectCity == '') {
        SCHttpManager.instance.post(
            url: SCUrl.kSearchCommunityByLocationUrl,
            params: {
              'latitude': searchState.latitude,
              'longitude': searchState.longitude,
              'city': searchState.locationCity,
              'range': 5000},
            success: (value) {
              log('通过经纬度获取项目数据===$value');
              communityList = List<SCCommunityModel>.from(value.map((e) => SCCommunityModel.fromJson(e)).toList());
              updateCommunityList(list: communityList);
            },
            failure: (value) {
              String message = value['message'];
              SCToast.showTip(message);
              updateCommunityList(list: []);
            });
      } else {
        SCHttpManager.instance.post(
            url: SCUrl.kSearchCommunityByCityUrl,
            params: {'conditions': {'city': searchState.selectCity}},
            success: (value) {
              log('通过城市获取项目数据===$value');
              var data = value['records'];
              log('data===$data');
              if (data.length > 0) {
                communityList = List<SCCommunityModel>.from(data.map((e) => SCCommunityModel.fromJson(e)).toList());
                updateCommunityList(list: communityList);
              } else {
                updateCommunityList(list: []);
              }
            },
            failure: (value) {
              String message = value['message'];
              SCToast.showTip(message);
              updateCommunityList(list: []);
            });
      }
    }
  }
}