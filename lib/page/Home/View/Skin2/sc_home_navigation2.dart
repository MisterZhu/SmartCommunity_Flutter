/// 首页-顶部导航栏2
import 'package:flutter/material.dart';
import 'package:smartcommunity/constants/sc_asset.dart';
import 'package:smartcommunity/constants/sc_fonts.dart';
import 'package:smartcommunity/utils/sc_utils.dart';

class SCHomeNavigation2 extends StatelessWidget {
  /// 背景颜色
  final Color? backgroundColor;

  /// 置顶颜色,默认白色
  final Color? stickyColor;

  /// 未置顶颜色,默认白色
  final Color? normalColor;

  /// 是否置顶
  final bool isSticky;

  /// 房号文本数字数量
  final int? titleMaxLength;

  /// 房号
  final String? roomTitle;

  /// 搜索文本
  final String? searchTitle;

  /// 切换房号
  final Function? changeHouseAction;

  SCHomeNavigation2({
    Key? key,
    this.backgroundColor = Colors.transparent,
    this.normalColor = Colors.white,
    this.stickyColor = Colors.white,
    this.isSticky = false,
    this.roomTitle = '慧享生活馆',
    this.titleMaxLength = 10,
    this.changeHouseAction,
    this.searchTitle = '搜索应用、商品、资讯',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          bottom: 0.0,
          left: 16.0,
          right: 16.0),
      decoration: BoxDecoration(color: getBackgroundColor()),
      child: body(),
    );
  }

  /// body
  Widget body() {
    return navItem();
  }

  /// 导航栏item
  Widget navItem() {
    return Container(
      height: 44.0,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [roomItem(), rightActionsItem()],
      ),
    );
  }

  /// 房号Widget
  Widget roomItem() {
    TextStyle style = TextStyle(
        fontSize: SCFonts.f14,
        color: isSticky == true ? stickyColor : normalColor,
        decoration: TextDecoration.none,
        fontWeight: FontWeight.normal);
    String roomString = roomTitle ?? '';
    String title = "";
    int maxLength = titleMaxLength ?? 10;

    if (roomString.length > maxLength) {
      /// 最多展示10个字
      title = '${roomString.substring(0, maxLength)}...';
    } else {
      title = roomString;
    }

    return GestureDetector(
      onTap: () {
        changeHouse();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: style,
          ),
          const SizedBox(
            width: 5.0,
          ),
          Image.asset(
            SCAsset.iconArrowDown,
            width: 14.0,
            height: 14.0,
            color: isSticky == true ? stickyColor : normalColor,
          ),
        ],
      ),
    );
  }

  /// Navigation-右侧按钮
  Widget rightActionsItem() {
    return Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              SCAsset.iconNavSearchWhite,
              width: 22.0,
              height: 22.0,
              color: isSticky == true ? stickyColor : normalColor,
            ),
            const SizedBox(
              width: 16.0,
            ),
            Image.asset(
              SCAsset.iconMessage,
              width: 22.0,
              height: 22.0,
              color: isSticky == true ? stickyColor : normalColor,
            ),
            const SizedBox(
              width: 16.0,
            ),
            Image.asset(
              SCAsset.iconScan,
              width: 22.0,
              height: 22.0,
              color: isSticky == true ? stickyColor : normalColor,
            ),
          ],
        ));
  }

  /// 背景颜色
  Color getBackgroundColor() {
    if (isSticky == true) {
      return backgroundColor ?? Colors.transparent;
    } else {
      return Colors.transparent;
    }
  }

  /// title颜色
  Color getTitleColor() {
    if (isSticky == true) {
      return stickyColor ?? Colors.transparent;
    } else {
      return normalColor ?? Colors.transparent;
    }
  }

  /// 切换房号
  void changeHouse() {
    changeHouseAction?.call();
  }
}
