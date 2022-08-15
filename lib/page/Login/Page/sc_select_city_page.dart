import 'dart:convert';

import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/constants/sc_fonts.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_city_controller.dart';
import 'package:smartcommunity/page/Login/View/SelectCity/sc_city_listview.dart';
import 'package:smartcommunity/page/Login/View/SelectCity/sc_city_search_result_listview.dart';

import '../../../utils/sc_utils.dart';
import '../GetXController/sc_city_search_controller.dart';
import '../Model/sc_city_model.dart';
import '../View/SelectCity/sc_city_search_header.dart';

class SCSelectCityPage extends StatefulWidget {
  @override
  SCSelectCityState createState() => SCSelectCityState();
}

class SCSelectCityState extends State<SCSelectCityPage> {
  List<SCCityModel> cityList = [];

  SCSelectCityController state = Get.put(SCSelectCityController());
  SCCitySearchController searchState = Get.put(SCCitySearchController());

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
    return GetBuilder<SCCitySearchController>(builder: (state){
      return SCCitySearchHeader(isShowCancel: state.isShowCancel);
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

}
