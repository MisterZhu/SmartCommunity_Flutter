
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:smartcommunity/constants/sc_fonts.dart';

import '../../../constants/sc_colors.dart';
import '../GetXController/sc_community_controller.dart';
import '../Model/sc_city_model.dart';
import '../View/SelectCity/sc_city_search_header.dart';
import 'package:smartcommunity/page/Login/View/SelectCity/sc_city_search_result_listview.dart';
import 'package:smartcommunity/page/Login/View/SelectCommunity/sc_community_listView.dart';

class SCSelectCommunityPage extends StatefulWidget {
  @override
  SCSelectCommunityState createState() => SCSelectCommunityState();
}

class SCSelectCommunityState extends State<SCSelectCommunityPage> {
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
    return GetBuilder<SCSelectCommunityController>(builder: (state){
      return SCCitySearchHeader(isShowCancel: state.isSearch);
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

  /// 社区列表
  Widget communityListView() {
    return GetBuilder<SCSelectCommunityController>(builder: (state){
      if (state.isSearch) {
        return SCCitySearchResultListView(cityList: state.searchList, selectCityHandler: (SCCityModel model) {
          state.updateSelectCity(model: model);
        },);
      } else {
        return SCCommunityListView();
      }
    });
  }

}

