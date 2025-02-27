/// 首页-顶部导航栏1
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';

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

  /// 扫一扫
  final Function? scanAction;

  /// 消息详情
  final Function? messageAction;

  /// 搜索
  final Function? searchAction;

  /// 房号文本数字数量
  final int? titleMaxLength;

  /// 消息未读数量
  final int unreadNum;

  SCHomeNavigation1(
      {Key? key,
      required this.unreadNum,
      this.backgroundColor = Colors.transparent,
      this.normalColor = Colors.white,
      this.stickyColor = Colors.black,
      this.isSticky = false,
      this.roomTitle = '慧享生活馆慧享生活馆慧享生活馆慧享生活馆慧享生活馆慧享生活馆慧享生活馆',
      this.changeHouseAction,
      this.scanAction,
      this.messageAction,
      this.searchAction,
      this.searchTitle = '搜索应用、商品、资讯',
      this.opacity = 1.0,
      this.titleMaxLength = 10})
      : super(key: key);

  /// 未读组件高出消息icon8.0
  double topOffset = 8.0;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity ?? 1.0,
      child: Container(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            bottom: 20.0,
            left: 16.0,
            right: 16.0),
        decoration: BoxDecoration(color: getBackgroundColor()),
        child: body(context),
      ),
    );
  }

  /// body
  Widget body(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        scanItem(context),
        // searchItem(),
      ],
    );
  }

  /// 房号、扫一扫、消息item
  Widget scanItem(BuildContext context) {
    return Container(
      height: 44.0,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [houseItem(context), rightActionsItem()],
      ),
    );
  }

  /// 房号Widget
  Widget houseItem(BuildContext context) {
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

    double width = SCUtils.boundingTextSize(context, title, style).width;
    return Visibility(
        visible: SCScaffoldManager.instance.isLogin,
        child: GestureDetector(
          onTap: () {
            changeHouse();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
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
                width: width,
                child: Text(
                  title,
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
              )
            ],
          ),
        ));
  }

  /// Navigation-右侧按钮
  Widget rightActionsItem() {
    return Expanded(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        messageItem(),
        const SizedBox(
          width: 16.0,
        ),
        // GestureDetector(
        //   child: Image.asset(
        //     SCAsset.iconScan,
        //     width: 24.0,
        //     height: 24.0,
        //     color: isSticky == true ? stickyColor : normalColor,
        //   ),
        //   onTap: () {
        //     scan();
        //   },
        // ),
      ],
    ));
  }

  Widget messageItem() {
    if (unreadNum > 0) {
      return SizedBox(
        width: 36.0,
        height: 30,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Positioned(
              bottom: 0,
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
        // color: SCColors.color_000000,
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


  /// 搜索框item
  Widget searchItem() {
    return GestureDetector(
      onTap: () {
        searchAction?.call();
      },
      child: Container(
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
                child: Opacity(
                  opacity: 0.6,
                  child: Text(
                    searchTitle ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontSize: SCFonts.f12,
                        fontWeight: FontWeight.normal),
                  ),
                ))
          ],
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

  /// 扫一扫
  void scan() {
    scanAction?.call();
  }

  /// 消息详情
  void message() {
    messageAction?.call();
  }
}
