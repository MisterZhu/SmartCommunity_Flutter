import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:smartcommunity/constants/sc_asset.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_city_controller.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_city_search_controller.dart';
import 'package:smartcommunity/page/Login/Model/sc_city_model.dart';
import 'package:smartcommunity/page/Login/View/SelectCity/sc_city_search_view.dart';
import 'package:smartcommunity/utils/sc_utils.dart';

import '../../../../constants/sc_fonts.dart';

/// 城市-搜索框

class SCCitySearchItem extends StatelessWidget {

  final bool isShowCancel;

  SCCitySearchItem({Key? key, this.isShowCancel = false}) : super(key: key);

  // controller
  TextEditingController controller = TextEditingController();

  /// focusNode
  FocusNode node = FocusNode();

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  /// body
  Widget body(BuildContext context) {
    if (isShowCancel) {
      showKeyboard(context);
      return Container(
        padding: const EdgeInsets.only(left: 16.0),
        child: Row(
            children: [
              Expanded(child: searchItem(context)),
              const SizedBox(width: 6,),
              cancelItem()
            ]
        ),
      );
    } else {
      return const Padding(padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 7.0),
          child: SCCitySearchView());
    }
  }

  showKeyboard(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 100),(){
      FocusScope.of(context).requestFocus(node);
    });
  }

  Widget cancelItem() {
    return CupertinoButton(
      padding: EdgeInsets.zero,
        child: const Text(
          '取消',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.normal,
            color: SCColors.color_000000,
          ),),
        onPressed: () {
          cancelItemClick();
        }
    );
  }

  /// 点击取消按钮
  cancelItemClick () {
    SCSelectCityController state = Get.find<SCSelectCityController>();
    state.updateSearchResult(status: false);
    state.updateSearchList(list: []);

    SCCitySearchController searchState = Get.find<SCCitySearchController>();
    searchState.updateSearchStatus(status: false);
  }

  /// 搜索框
  Widget searchItem (BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 17.0),
      height: 30.0,
      decoration: BoxDecoration(
          color: SCColors.color_F2F3F5,
          borderRadius: BorderRadius.circular(15.0)
      ),
      child: Row(
        children: [
          searchIcon(),
          const SizedBox(width: 10.0,),
          searchTextField(context)
        ],
      ),
    );
  }

  /// 搜索icon
  Widget searchIcon() {
    return Image.asset(SCAsset.iconLocationSearchCity, width: 16.0, height: 16.0,);
  }

  ///  搜索框
  Widget searchTextField(BuildContext context) {
    return Expanded(child: TextField(
      controller: controller,
      maxLines: 1,
      cursorColor: SCColors.color_1B1C33,
      cursorWidth: 2,
      focusNode: node,
      style: const TextStyle(fontSize: SCFonts.f14, fontWeight: FontWeight.w400, color: SCColors.color_1B1C33),
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 0),
        hintText: "搜索城市",
        hintStyle: TextStyle(fontSize: SCFonts.f14, fontWeight: FontWeight.w400, color: SCColors.color_B0B1B8),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        border: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        isCollapsed: true,
      ),
      onChanged: (value) {
        valueChanged(value);
      },
      onSubmitted: (value) {
        SCUtils().hideKeyboard(context: context);
      },
      keyboardType: TextInputType.text,
      keyboardAppearance: Brightness.light,
      textInputAction: TextInputAction.search,
    ));
  }

  /// 输入框内容改变
  valueChanged(String value) {
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
        log('搜索数据:${list}');
      }
    } else {
      state.updateSearchList(list: []);
    }
  }
}