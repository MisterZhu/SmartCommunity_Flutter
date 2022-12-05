import 'package:flutter/material.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:sc_uikit/sc_uikit.dart';

/// 我的-顶部导航栏

class SCMineNavigation extends StatelessWidget {

  /// 透明度
  final double? opacity;

  /// 背景颜色
  final Color? backgroundColor;

  /// 组件颜色
  final Color? itemColor;

  /// 是否置顶
  final bool isSticky;

  /// 点击设置
  final Function? settingAction;

  SCMineNavigation(
      {Key? key,
        this.opacity = 1.0,
        this.backgroundColor = Colors.transparent,
        this.itemColor = Colors.white,
        this.isSticky = false,
        this.settingAction,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(opacity: opacity ?? 1.0, child: Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          bottom: 0.0,
          left: 20.0,
          right: 20.0),
      decoration: BoxDecoration(color: getBackgroundColor()),
      child: body(),
    ),);
  }

  /// body
  Widget body() {
    return Container(
      height: 44.0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 22.0,),
          titleItem(),
          settingItem(),
        ],
      ),
    );
  }

  /// title
  Widget titleItem() {
    return Expanded(child: Text('我的', textAlign: TextAlign.center ,maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(
        fontSize: SCFonts.f18,
        color: getItemColor(),
        fontWeight: FontWeight.w500
    ),));
  }

  /// 设置icon
  Widget settingItem() {
    return GestureDetector(
      onTap: (){
        if (settingAction != null) {
          settingAction?.call();
        }
      },
      child: Image.asset(
        SCAsset.iconSettingBlack,
        width: 22.0,
        height: 22.0,
        color: getItemColor(),
      ),
    );
  }

  /// 背景颜色
  Color getBackgroundColor() {
    if (isSticky == true) {
      return backgroundColor ?? Colors.transparent;
    } else {
      return Colors.transparent;
    }
  }

  /// 文本颜色
  Color getItemColor() {
    return itemColor ?? SCColors.color_1B1D33;
  }
}