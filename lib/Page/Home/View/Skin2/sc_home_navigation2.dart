/// 首页-顶部导航栏2
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';

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

  /// 扫一扫
  final Function? scanAction;

  /// 搜索
  final Function? searchAction;

  /// 消息
  final Function? messageAction;

  /// 消息未读数量
  final int unreadNum;

  SCHomeNavigation2({
    Key? key,
    required this.unreadNum,
    this.backgroundColor = Colors.transparent,
    this.normalColor = Colors.white,
    this.stickyColor = Colors.white,
    this.isSticky = false,
    this.roomTitle = '慧享生活馆',
    this.titleMaxLength = 10,
    this.changeHouseAction,
    this.searchAction,
    this.scanAction,
    this.messageAction,
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
        children: [rightActionsItem()],
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

    return Visibility(
        visible: SCScaffoldManager.instance.isLogin,
        child: GestureDetector(
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
            ],
          ),
        ));
  }

  /// Navigation-右侧按钮
  Widget rightActionsItem() {
    return Expanded(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // GestureDetector(
        //   onTap: () {
        //     searchAction?.call();
        //   },
        //   child: Image.asset(
        //     SCAsset.iconNavSearchWhite,
        //     width: 22.0,
        //     height: 22.0,
        //     color: isSticky == true ? stickyColor : normalColor,
        //   ),
        // ),
        // const SizedBox(
        //   width: 16.0,
        // ),
        // GestureDetector(
        //   onTap: () {
        //     messageAction?.call();
        //   },
        //   child: Image.asset(
        //     SCAsset.iconMessage,
        //     width: 22.0,
        //     height: 22.0,
        //     color: isSticky == true ? stickyColor : normalColor,
        //   ),
        // ),
        const SizedBox(
          width: 16.0,
        ),
        GestureDetector(
          onTap: () {
            scanAction?.call();
          },
          child: Image.asset(
            SCAsset.iconScanB,
            width: 22.0,
            height: 22.0,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          width: 16.0,
        ),
        messageItem(),
      ],
    ));
  }


  Widget messageItem() {
    if (unreadNum > 0) {
      return SizedBox(
        width: 30.0,
        height: 30,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Positioned(
              bottom: 3,
              left: 0,
              right: 0,
              child: bellIcon(),),
            Positioned(
              top: 0,
              right: 0,
              child: unreadItem(),)
          ],
        ),
      );
    } else {
      return bellIcon();
    }
  }

  /// 消息icon
  Widget bellIcon() {
    return GestureDetector(
      child: Image.asset(
        SCAsset.iconMessage_black,
        width: 24.0,
        height: 24.0,
        color: Colors.black,
      ),
      onTap: () {
        message();
      },
    );
  }

  /// 未读数量
  Widget unreadItem() {
    String text = unreadNum > 99 ? '99+' : '$unreadNum';
    return Offstage(
      offstage: unreadNum == 0,
      child: Container(
        height: 14.0,
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: SCColors.color_FF4040,
            borderRadius: BorderRadius.circular(7.0),
            border: Border.all(color: SCColors.color_FFFFFF, width: 0.5)),
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              fontSize: SCFonts.f10,
              fontWeight: FontWeight.w500,
              color: SCColors.color_FFFFFF),
        ),
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

  /// 消息详情
  void message() {
    messageAction?.call();
  }
}
