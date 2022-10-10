
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartcommunity/constants/sc_asset.dart';
import '../../../../constants/sc_colors.dart';
import '../../../../constants/sc_default_value.dart';
import '../../../../constants/sc_fonts.dart';
import '../../../../utils/Router/sc_router_helper.dart';
import '../../../../utils/sc_utils.dart';

/// 登录页面顶部item

class SCLoginHeader extends StatelessWidget {

  final bool showClose;

  SCLoginHeader({Key? key, this.showClose = true,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Stack(
      children: [
        Positioned(child: bgImageItem()),
        Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: titleItem()),
        Positioned(
          top: SCUtils().getStatusBarHeight(),
          right: 10.0,
          child: closeItem())
      ],
    );
  }

  /// 背景图片
  Widget bgImageItem() {
    double imageScale = 750 / 474.0;
    return AspectRatio(
      aspectRatio: imageScale,
      child: Image.asset(
        SCAsset.iconLoginTopBg,
        fit: BoxFit.fill,
      ),
    );
  }

  /// 文字item
  Widget titleItem() {
    return const Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 35.0, top: 0.0),
      child: Text(
        '欢迎进入${SCDefaultValue.appName}',
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: SCFonts.f22,
          fontWeight: FontWeight.w400,
          color: SCColors.color_1B1C33,
        ),),
    );
  }

  Widget closeItem() {
    return Offstage(
      offstage: true,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Container(
          width: 40.0,
          height: 24.0,
          alignment: Alignment.center,
          child: Image.asset(
          SCAsset.iconLoginClose,
            width: 24.0,
            height: 24.0,
          ),
      ),
      onPressed: () {
        SCRouterHelper.back(null);
      })
    );
  }
}