import 'dart:developer';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/Page/Login/GetXController/sc_search_community_controller.dart';
import 'package:smartcommunity/Utils/Loading/sc_loading_utils.dart';

import '../../../Network/sc_http_manager.dart';
import '../../../Network/sc_url.dart';
import '../../../Utils/Toast/sc_toast.dart';
import '../Model/sc_community_model.dart';

/// 选择社区-Controller

class SCSelectCommunityController extends GetxController {
  /// 社区列表数据源
  List<SCCommunityModel> communityList = [];

  /// 搜索的数据源
  List<SCCommunityModel> searchList = [];

  /// 是否搜索结果页面
  bool isShowResult = false;

  String keyword = '';

  /// 选择的社区
  SCCommunityModel? selectCommunityModel;

  /// 园区范围，默认5000米
  int range = 5000;

  EasyRefreshController refreshController = EasyRefreshController(
      controlFinishLoad: true, controlFinishRefresh: true);

  int currentPage = 1;
  int pageSize = 100;
  @override
  onInit() {
    super.onInit();
  }

  updateKeyword(String value) {
    keyword = value;

    /// 先清空之前的数据，再请求数据
    searchList = [];
    update();
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

  /// 选择城市后获取园区数据
  loadCommunityData({bool isLoadMore = false}) async {
    if (isLoadMore == false) {
      SCLoadingUtils.show();
    }
    SCSearchCommunityController searchState =
        Get.find<SCSearchCommunityController>();

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
              'range': range
            },
            success: (value) {
              communityList = List<SCCommunityModel>.from(
                  value.map((e) => SCCommunityModel.fromJson(e)).toList());
              if (communityList.isEmpty) {
                refreshController.finishRefresh(IndicatorResult.success);
                refreshController.finishLoad(IndicatorResult.noMore);
              } else {
                refreshController.finishRefresh(IndicatorResult.success);
                refreshController.finishLoad(IndicatorResult.noMore);
              }
              updateCommunityList(list: communityList);
            },
            failure: (value) {
              refreshController.finishRefresh(IndicatorResult.success);
              refreshController.finishLoad(IndicatorResult.noMore);
              if (value['message'] != null) {
                String message = value['message'];
                SCToast.showTip(message);
              }
              updateCommunityList(list: []);
            });
      } else {
        int curPage = 1;
        if (isLoadMore) {
          curPage = currentPage + 1;
        } else {
          currentPage = 1;
        }

        SCHttpManager.instance.post(
            url: SCUrl.kSearchCommunityByCityUrl,
            params: {
              'conditions': {'city': searchState.selectCity},
              'pageNum': curPage,
              'pageSize': pageSize
            },
            success: (value) {
              log('通过城市获取项目数据===$value');
              var data = value['records'];
              List<SCCommunityModel> dataList = List<SCCommunityModel>.from(
                  data.map((e) => SCCommunityModel.fromJson(e)).toList());
              if (isLoadMore) {
                if (dataList.isNotEmpty) {
                  communityList.addAll(dataList);
                  currentPage++;
                  refreshController.finishLoad(IndicatorResult.success);
                } else {
                  refreshController.finishLoad(IndicatorResult.noMore);
                }
              } else {
                communityList = dataList;
                refreshController.finishRefresh(IndicatorResult.none);
                refreshController.resetFooter();
              }
              updateCommunityList(list: communityList);
            },
            failure: (value) {
              log('请求失败=====$value');
              refreshController.finishRefresh(IndicatorResult.success);
              refreshController.finishLoad(IndicatorResult.success);
              if (value['message'] != null) {
                String message = value['message'];
                SCToast.showTip(message);
              }
              updateCommunityList(list: []);
            });
      }
    }
  }

  /// 搜索园区数据
  loadSearchResultData({bool isLoadMore = false}) {
    if (isLoadMore == false) {
      SCLoadingUtils.show();
    }
    int curPage = 1;
    if (isLoadMore) {
      curPage = currentPage + 1;
    } else {
      currentPage = 1;
    }
    SCSearchCommunityController searchState =
        Get.find<SCSearchCommunityController>();

    String city = searchState.selectCity;
    if (searchState.selectCity == '') {
      city = searchState.locationCity;
    }
    SCHttpManager.instance.post(
        url: SCUrl.kSearchCommunityByCityUrl,
        params: {
          'conditions': {'city': city, 'name': keyword},
          'pageNum': curPage,
          'pageSize': pageSize
        },
        success: (value) {
          var data = value['records'];
          //log('搜索结果data===$data');
          List<SCCommunityModel> dataList = List<SCCommunityModel>.from(
              data.map((e) => SCCommunityModel.fromJson(e)).toList());
          if (isLoadMore) {
            if (dataList.isNotEmpty) {
              communityList.addAll(dataList);
              currentPage++;
              refreshController.finishLoad(IndicatorResult.success);
            } else {
              refreshController.finishLoad(IndicatorResult.noMore);
            }
          } else {
            communityList = dataList;
            refreshController.finishRefresh(IndicatorResult.success);
            refreshController.resetFooter();
          }
          updateSearchList(list: communityList);
        },
        failure: (value) {
          refreshController.finishRefresh(IndicatorResult.success);
          refreshController.resetFooter();
          log('请求失败=====$value');
          if (value['message'] != null) {
            String message = value['message'];
            SCToast.showTip(message);
          }
          updateSearchList(list: []);
        });
  }

  @override
  onClose() {
    super.onClose();
    refreshController.dispose();
  }
}
