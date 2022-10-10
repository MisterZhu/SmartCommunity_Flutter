

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/constants/sc_default_value.dart';
import 'package:smartcommunity/utils/Router/sc_router_helper.dart';

import '../../../constants/sc_asset.dart';
import '../../../constants/sc_colors.dart';
import '../../../constants/sc_fonts.dart';
import '../../../utils/Router/sc_router_path.dart';

/// 首页悬浮登录

class SCHomeFloatLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  /// body
  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
      child: Container(
        height: 80.0,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.8),
            borderRadius: BorderRadius.circular(6.0)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            iconItem(),
            const SizedBox(width: 12.0,),
            contentItem(),
            const SizedBox(width: 10.0,),
            loginBtnItem()
          ],
        ),
      ),
    );
  }

  /// icon
  Widget iconItem() {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0)),
      child: Image.asset(SCAsset.iconLogo60, width: 40.0, height: 40.0,),
    );
  }

  /// content
  Widget contentItem() {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            '欢迎来到${SCDefaultValue.appName}～',
            textAlign: TextAlign.left,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w500,
              color: SCColors.color_FFFFFF,
          ),),
          SizedBox(height: 3.0,),
          Text(
            '赶快登录打开新的世界吧',
            textAlign: TextAlign.left,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: SCFonts.f12,
              fontWeight: FontWeight.w400,
              color: SCColors.color_FFFFFF,
            ),),
        ],
      )
    );
  }

  /// 登录按钮
  Widget loginBtnItem() {
    return Container(
      width: 80.0,
      height: 30.0,
      decoration: BoxDecoration(
          color: SCColors.color_00C365,
          borderRadius: BorderRadius.circular(15.0)),
      child: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text(
            '马上登录',
            style: TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: SCColors.color_FFFFFF,
            ),
          ),
          onPressed: () {
            SCRouterHelper.pathPage(SCRouterPath.codeLoginPath, null);
          }),
    );
  }

}