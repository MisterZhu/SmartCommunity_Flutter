
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import '../../../../Constants/sc_default_value.dart';
import '../../../../Utils/Router/sc_router_helper.dart';
import '../../../../Utils/sc_utils.dart';

/// 登录页面顶部item

class SCLoginHeader extends StatelessWidget {

  /// 是否显示关闭按钮，默认不显示
  final bool showClose;

  /// 关闭按钮点击
  final Function? closeAction;

  SCLoginHeader({Key? key, this.showClose = false, this.closeAction}) : super(key: key);

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
      offstage: !showClose,
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
        if (closeAction != null) {
          closeAction?.call();
        }
      })
    );
  }
}