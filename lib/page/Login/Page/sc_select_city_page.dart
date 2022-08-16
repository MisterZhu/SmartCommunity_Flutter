import 'dart:convert';

import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/constants/sc_fonts.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_select_city_controller.dart';
import 'package:smartcommunity/page/Login/View/SelectCity/sc_city_listview.dart';
import 'package:smartcommunity/page/Login/View/SelectCity/sc_city_search_result_listview.dart';

import '../../../utils/sc_utils.dart';
import '../GetXController/sc_search_city_controller.dart';
import '../Model/sc_city_model.dart';
import '../View/SelectCity/sc_city_search_header.dart';

class SCSelectCityPage extends StatefulWidget {
  @override
  SCSelectCityState createState() => SCSelectCityState();
}

class SCSelectCityState extends State<SCSelectCityPage> {
  List<SCCityModel> cityList = [];

  SCSelectCityController state = Get.put(SCSelectCityController());
  SCSearchCityController searchState = Get.put(SCSearchCityController());

  @override
  void initState() {
    super.initState();
    loadData();
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
      return SCCitySearchHeader(isShowCancel: state.isShowCancel, cancelAction: (){
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
        return SCCitySearchResultListView(cityList: state.searchList, selectCityHandler: (SCCityModel model) {
          state.updateSelectCity(model: model);
        },);
      } else {
        return SCCityListView(cityList: state.cityList);
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
          String namePinYin = cityModel?.namePinyin ?? '';
          String tagIndex = cityModel?.tagIndex ?? '';
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

}
