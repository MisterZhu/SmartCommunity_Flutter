
import 'package:get/get.dart';

import '../Model/sc_community_model.dart';

/// 选择社区-Controller

class SCSelectCommunityController extends GetxController {
  /// 社区列表数据源
  List<SCCommunityModel>? communityList = [];

  /// 搜索的数据源
  List<SCCommunityModel>? searchList = [];

  /// 是否搜索结果页面
  bool isShowResult = false;

  /// 选择的社区
  SCCommunityModel? selectCommunityModel;

  @override
  onInit() {
    super.onInit();
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
}