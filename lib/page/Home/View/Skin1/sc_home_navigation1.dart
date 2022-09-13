/// 首页-顶部导航栏1
import 'package:flutter/material.dart';
import 'package:smartcommunity/constants/sc_asset.dart';
import 'package:smartcommunity/constants/sc_fonts.dart';

class SCHomeNavigation1 extends StatelessWidget {

  /// 透明度
  final double? opacity;

  /// 背景颜色
  final Color? backgroundColor;

  /// 置顶颜色,默认黑色
  final Color? stickyColor;

  /// 未置顶颜色,默认白色
  final Color? normalColor;

  /// 是否置顶
  final bool isSticky;

  /// 房号文本最大宽度
  double titleMaxWidth = 160.0;

  /// 房号
  final String? roomTitle;

  /// 搜索文本
  final String? searchTitle;

  /// 切换房号
  final Function? changeHouseAction;

  SCHomeNavigation1(
      {Key? key,
      this.backgroundColor = Colors.transparent,
      this.normalColor = Colors.white,
      this.stickyColor = Colors.black,
      this.isSticky = false,
      this.roomTitle = '慧享生活馆慧享生活馆慧享生活馆慧享生活馆慧享生活馆慧享生活馆慧享生活馆',
      this.changeHouseAction,
      this.searchTitle = '搜索应用、商品、资讯',
      this.opacity = 1.0,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(opacity: opacity ?? 1.0, child: Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          bottom: 20.0,
          left: 16.0,
          right: 16.0),
      decoration: BoxDecoration(color: getBackgroundColor()),
      child: body(),
    ),);
  }

  /// body
  Widget body() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        scanItem(),
        searchItem(),
      ],
    );
  }

  /// 房号、扫一扫、消息item
  Widget scanItem() {
    return Container(
      height: 44.0,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [houseItem(), rightActionsItem()],
      ),
    );
  }

  /// 房号Widget
  Widget houseItem() {
    return Expanded(
        child: GestureDetector(
      onTap: () {
        changeHouse();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            SCAsset.iconLocation,
            width: 12.0,
            height: 14.0,
            color: isSticky == true ? stickyColor : normalColor,
          ),
          const SizedBox(
            width: 8.0,
          ),
          SizedBox(
            width: titleMaxWidth,
            child: Text(
              '$roomTitle',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                  fontSize: SCFonts.f14,
                  color: isSticky == true ? stickyColor : normalColor,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal),
            ),
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
    ));
  }

  /// Navigation-右侧按钮
  Widget rightActionsItem() {
    return Row(
      children: [
        Image.asset(
          SCAsset.iconScan,
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
      ],
    );
  }

  /// 搜索框item
  Widget searchItem() {
    return Container(
      height: 30.0,
      padding: const EdgeInsets.symmetric(horizontal: 19.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            SCAsset.iconWhiteSearch,
            width: 15.0,
            height: 15.0,
          ),
          const SizedBox(
            width: 5.0,
          ),
          Expanded(
              child: Opacity(opacity: 0.6, child: Text(
                searchTitle ?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontSize: SCFonts.f12,
                    fontWeight: FontWeight.normal),
              ),))
        ],
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
