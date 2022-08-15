
import 'package:get/get.dart';

import '../Model/sc_city_model.dart';

/// 选择社区-Controller

class SCSelectCommunityController extends GetxController {
  /// 社区列表数据源
  List<SCCityModel>? cityList = [];

  /// 搜索的数据源
  List<SCCityModel>? searchList = [];

  /// 是否正在搜索
  bool isSearch = false;

  /// 选择的城市
  SCCityModel? selectCommunityModel;

  @override
  onInit() {
    super.onInit();
  }

  /// 更新城市列表数据源
  updateCityList({required List<SCCityModel> list}) {
    cityList = list;
    update();
  }

  /// 更新搜索的数据源
  updateSearchList({required List<SCCityModel> list}) {
    searchList = list;
    update();
  }

  /// 选择的城市
  updateSelectCity({required SCCityModel model}) {
    selectCommunityModel = model;
    isSearch = false;
    update();
  }

  /// 是否正在搜索
  updateSearchStatus({bool status = false}) {
    isSearch = status;
    update();
  }
}