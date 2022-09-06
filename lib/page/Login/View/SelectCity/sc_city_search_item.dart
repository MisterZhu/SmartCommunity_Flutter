import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smartcommunity/constants/sc_asset.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/page/Login/View/SelectCity/sc_city_search_view.dart';
import 'package:smartcommunity/utils/sc_utils.dart';

import '../../../../constants/sc_fonts.dart';
import '../../GetXController/sc_search_city_controller.dart';
import '../../GetXController/sc_select_city_controller.dart';

/// 城市-搜索框

class SCCitySearchItem extends StatelessWidget {
  /// 是否显示取消按钮
  final bool isShowCancel;
  /// 取消
  final Function? cancelAction;
  /// 文本框内容改变
  final Function(String value)? valueChangedAction;

  SCCitySearchItem({Key? key, this.isShowCancel = false, this.cancelAction, this.valueChangedAction}) : super(key: key);

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
      return Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 7.0),
          child: SCCitySearchView(placeHolder: '搜索城市', textViewTapAction: (){
            showCancelButton();
          },));
    }
  }

  showCancelButton() {
    SCSearchCityController searchState = Get.find<SCSearchCityController>();
    searchState.updateCancelButtonStatus(status: true);

    SCSelectCityController state = Get.find<SCSelectCityController>();
    state.updateSearchResult(status: true);
  }

  showKeyboard(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 100),(){
      node.requestFocus();
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
    node.unfocus();
    if (cancelAction != null) {
      cancelAction?.call();
    }
  }

  /// 搜索框
  Widget searchItem(BuildContext context) {
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
  }
}