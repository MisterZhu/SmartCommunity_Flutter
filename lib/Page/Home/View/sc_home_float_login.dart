

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_default_value.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';

import '../../../Constants/sc_asset.dart';
import '../../../Utils/Router/sc_router_path.dart';

/// 首页悬浮登录

class SCHomeFloatLogin extends StatelessWidget {

  /// 点击回调
  final Function? onTap;

  const SCHomeFloatLogin({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  /// body
  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
      child: Container(
        height: 60.0,
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
            color: SCColors.color_1B1D33.withOpacity(0.9),
            borderRadius: BorderRadius.circular(8.0)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            iconItem(),
            const SizedBox(width: 10.0,),
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
      width: 36.0,
      height: 36.0,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0)),
      child: Image.asset(SCAsset.iconLogo60, width: 36.0, height: 36.0,),
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
            '欢迎来到${SCDefaultValue.appName}',
            textAlign: TextAlign.left,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: SCFonts.f13,
              fontWeight: FontWeight.w400,
              color: SCColors.color_FFFFFF,
          ),),
          SizedBox(height: 2.0,),
          Text(
            '赶快登录打开新的世界吧',
            textAlign: TextAlign.left,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: SCFonts.f13,
              fontWeight: FontWeight.w400,
              color: SCColors.color_FFFFFF,
            ),),
        ],
      )
    );
  }

  /// 登录按钮
  Widget loginBtnItem() {
    return SizedBox(
      width: 72.0,
      height: 26.0,
      child: CupertinoButton(
          padding: EdgeInsets.zero,
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.circular(13.0),
          child: const Text(
            '立即登录',
            style: TextStyle(
              fontSize: SCFonts.f12,
              fontWeight: FontWeight.w400,
              color: SCColors.color_000000,
            ),
          ),
          onPressed: () {
            onTap?.call();
          }),
    );
  }

}