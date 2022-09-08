import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/constants/sc_asset.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/constants/sc_fonts.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_select_house_data_controller.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_select_house_search_status_controller.dart.dart';
import 'package:smartcommunity/page/Login/Model/SelectHouse/sc_select_house_block_model.dart';
import 'package:smartcommunity/page/Login/View/SelectHouse/sc_select_house_search_static_view.dart';

/// Copyright (c), 浙江慧享信息科技有限公司
/// FileName: sc_select_house_search_view
/// Author: wang tao
/// Email: wangtao1@lvchengfuwu.com
/// Date: 2022/8/18 11:46
/// Description: 搜索框 - 可输入
class SCHouseSearchDynamicView extends StatelessWidget {

  final bool isShowCancel;

  /// 取消
  final Function? cancelAction;

  /// 文本框内容改变
  final Function(String value)? valueChangedAction;

  SCHouseSearchDynamicView({Key? key, this.isShowCancel = false, this.cancelAction, this.valueChangedAction}) : super(key: key);

  // controller
  final TextEditingController controller = TextEditingController();

  /// focusNode
  final FocusNode node = FocusNode();

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  /// body
  Widget body(BuildContext context) {
    if (isShowCancel) {
      showKeyboard(context);
      return Container(
        child: Row(
            children: [
              Expanded(child: searchItem(context)),
              const SizedBox(width: 6,),
              cancelItem()
            ]
        ),
      );
    } else {
      return SCSelectHouseSearchStaticView();
    }
  }

  showCancelButton() {
    // SCSearchCityController searchState = Get.find<SCSearchCityController>();
    // searchState.updateCancelButtonStatus(status: true);
    //
    // SCSelectCityController state = Get.find<SCSelectCityController>();
    // state.updateSearchResult(status: true);
  }

  showKeyboard(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 100),(){
      node.requestFocus();
    });
  }

  Widget cancelItem() {
    return Container(
        color: SCColors.color_FFFFFF,
        padding: const EdgeInsets.only(left: 5),
        child: GestureDetector(
          child: const Text(
            '取消',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.normal,
              color: SCColors.color_000000,
            ),
          ),
          onTap: () {
            cancelItemClick();
          },
        ));
  }

  /// 点击取消按钮
  cancelItemClick () {
    node.unfocus();
    if (cancelAction != null) {
      cancelAction?.call();
    }
    SCSelectHouseDataController state = Get.find<SCSelectHouseDataController>();
    SCSelectHouseSearchStatusController sCSelectHouseState = Get.find<SCSelectHouseSearchStatusController>();
    sCSelectHouseState.updateSearchStatus(isShowCancel: false);
    state.updateSearchList(list: []);
  }

  /// 搜索框
  Widget searchItem(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      height: 36.0,
      decoration: BoxDecoration(
          color: SCColors.color_F2F3F5,
          borderRadius: BorderRadius.circular(18.0)),
      child: Row(
        children: [
          searchIcon(),
          const SizedBox(
            width: 10.0,
          ),
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
        hintText: "请输入",
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
        node.unfocus();
      },
      keyboardType: TextInputType.text,
      keyboardAppearance: Brightness.light,
      textInputAction: TextInputAction.search,
    ));
  }

  /// 输入框内容改变
  valueChanged(String value) {
    if (valueChangedAction != null) {
      valueChangedAction?.call(value);
    }
    SCSelectHouseDataController state = Get.find<SCSelectHouseDataController>();
    List<ScSelectHouseModel> houseCommunityList = state.dataList;
    List<ScSelectHouseModel> searchResultList = [];
    if(value.isNotEmpty) {
      if(houseCommunityList != null){
        for(int i = 0; i < houseCommunityList.length; i++) {
          ScSelectHouseModel scSelectHouseModel = houseCommunityList[i];
          String? name = scSelectHouseModel.name;
          if(name!.contains(value)) {
            searchResultList.add(scSelectHouseModel);
          }
        }
      }
      state.updateSearchList(list:searchResultList);
    } else {
      print('-->输入的东西为空');
      state.updateSearchList(list:[]);
    }
  }
}
