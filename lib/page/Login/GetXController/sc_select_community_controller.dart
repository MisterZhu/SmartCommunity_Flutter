
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

    /// 测试数据
    var testList = [
      {'name':'慧享生活园区','id':1, 'address':'文一西路767号','distance':'<300m'},
      {'name':'绿城园区','id':2, 'address':'文一西路777号','distance':'<500m'},
      {'name':'蒋村地铁','id':3, 'address':'文二路11号','distance':'<600m>'},
      {'name':'天堂软件园','id':4, 'address':'北京路88号','distance':'<1km>'},
      {'name':'蒋村商务中心','id':5, 'address':'文涛路99号','distance':'<2km'}
    ];
    communityList = testList.map((e) => SCCommunityModel.fromJson(e)).toList();

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