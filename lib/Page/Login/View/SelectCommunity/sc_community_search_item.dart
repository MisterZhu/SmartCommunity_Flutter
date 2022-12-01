import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Constants/sc_colors.dart';
import 'package:smartcommunity/Page/Login/View/SelectCity/sc_city_search_view.dart';

import '../../../../Constants/sc_fonts.dart';
import '../../GetXController/sc_search_community_controller.dart';
import '../../GetXController/sc_select_community_controller.dart';

/// 社区-搜索框

class SCCommunitySearchItem extends StatelessWidget {
  /// 是否显示取消按钮
  final bool isShowCancel;
  /// 取消
  final Function? cancelAction;
  /// 搜索
  final Function(String value)? searchAction;
  /// 选择城市
  final Function? selectCityAction;
  /// 选择的城市
  final String? selectCity;

  SCCommunitySearchItem(
      {
        Key? key,
        this.selectCity = '请选择',
        this.isShowCancel = false,
        this.cancelAction,
        this.searchAction,
        this.selectCityAction,
        required this.node,
      }) : super(key: key);

  // controller
  final TextEditingController controller = TextEditingController();

  /// focusNode
  final FocusNode node;

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
              leftCityItem(context),
              const SizedBox(width: 4,),
              Expanded(child: searchItem(context)),
              const SizedBox(width: 6,),
              cancelItem(context)
            ]
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 7),
        child: Row(
          children: [
            leftCityItem(context),
            const SizedBox(width: 4,),
            Expanded(child: SCCitySearchView(placeHolder: '查找社区/园区/小镇等', textViewTapAction: () {
                showCancelButton();
            })),
          ],
        )
      );
    }
  }

  showCancelButton() {
    SCSearchCommunityController searchState = Get.find<SCSearchCommunityController>();
    searchState.updateCancelButtonStatus(status: true);

    SCSelectCommunityController state = Get.find<SCSelectCommunityController>();
    state.updateSearchResult(status: true);
  }

  showKeyboard(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 100),(){
      node.requestFocus();
    });
  }

  Widget leftCityItem(BuildContext context) {
    String cityString = selectCity ?? '请选择';
    if (selectCity == '') {
      cityString = '请选择';
    }

    return GestureDetector(
      child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 44,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Text(
                cityString,
                maxLines: 1,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  color: SCColors.color_000000,
                ),),
            ),
            const SizedBox(width: 3.0,),
            Container(
              padding: const EdgeInsets.only(bottom: 4),
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Image.asset(SCAsset.iconSelectCityArrow, width: 20.0, height: 20.0,),
            )
          ],
        ),
      onTap: () {
        // 收起键盘
        node.unfocus();
        if (selectCityAction != null) {
          selectCityAction?.call();
        }
      },
    );
  }

  Widget cancelItem(BuildContext context) {
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
          node.unfocus();
          cancelItemClick();
        }
    );
  }

  /// 点击取消按钮
  cancelItemClick() {
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
        hintText: "查找社区/园区/小镇等",
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
        // valueChanged(value);
      },
      onSubmitted: (value) {
        if (value.isNotEmpty) {
          searchSubmitted(value);
          node.unfocus();
        }
      },
      keyboardType: TextInputType.text,
      keyboardAppearance: Brightness.light,
      textInputAction: TextInputAction.search,
    ));
  }

  /// 点击搜索
  searchSubmitted(String value) {
    if (searchAction != null) {
      searchAction?.call(value);
    }
  }
}