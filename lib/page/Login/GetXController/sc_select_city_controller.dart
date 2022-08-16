import 'package:get/get.dart';

import '../Model/sc_city_model.dart';

/// 选择城市-Controller

class SCSelectCityController extends GetxController {
  /// 城市列表数据源
  List<SCCityModel>? cityList = [];

  /// 搜索的数据源
  List<SCCityModel>? searchList = [];

  /// 是否搜索结果页面
  bool isShowResult = false;

  /// 选择的城市
  SCCityModel? selectCityModel;

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
    selectCityModel = model;
    isShowResult = false;
    update();
  }

  /// 是否正在搜索
  updateSearchResult({bool status = false}) {
    isShowResult = status;
    update();
  }
}