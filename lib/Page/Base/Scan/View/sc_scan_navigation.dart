import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';

/// 扫一扫-顶部导航栏

class SCScanNavigation extends StatelessWidget {

  /// 是否开启闪光灯
  final bool isOpenFlash;

  /// 点击返回
  final Function? tapBack;
  /// 点击相册
  final Function? tapAlbum;
  /// 点击闪光灯
  final Function? tapFlash;

  SCScanNavigation({Key? key, this.isOpenFlash = false, this.tapBack, this.tapAlbum, this.tapFlash}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 44.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          backItem(),
          const Expanded(child: SizedBox()),
          albumItem(),
          flashItem()
        ],
      ),
    );
  }

  /// 返回按钮
  Widget backItem() {
    return button(icon: SCAsset.scanIconBack, onTap: () {
      tapBack?.call();
    });
  }

  /// 相册按钮
  Widget albumItem() {
    return button(icon: SCAsset.scanIconAlbum, onTap: () {
      tapAlbum?.call();
    });
  }

  /// 闪光灯按钮
  Widget flashItem() {
    return button(icon: isOpenFlash ? SCAsset.scanIconOrangeFlash : SCAsset.scanIconGreyFlash, onTap: () {
        tapFlash?.call();
    });
  }

  /// 按钮
  Widget button({required String icon, Function? onTap}) {
    return CupertinoButton(padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 6.0),child: Image.asset(icon, width: 28.0, height: 28.0, fit: BoxFit.contain,), onPressed: () {
      onTap?.call();
    });
  }
}