import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/constants/sc_asset.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/constants/sc_fonts.dart';
import 'package:smartcommunity/page/Home/GetXController/sc_home_controller.dart';

/// 设置页面cell

class SCSettingCell extends StatelessWidget {

  /// title
  final String? title;

  /// content
  final String? content;

  /// onTap
  final Function? onTap;

  const SCSettingCell({Key? key, this.title = '', this.content = '', this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return FlatButton(onPressed: (){
      clickAction();
    }, child: Padding(padding: const EdgeInsets.only(left: 0.0, right: 0.0), child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        titleWidget(),
        contentWidget(),
        arrowIcon()
      ],
    ),));
  }

  /// title
  Widget titleWidget() {
    String titleString = title ?? '';
    return Text(titleString, textAlign: TextAlign.left, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(
      fontSize: SCFonts.f16,
      fontWeight: FontWeight.w400,
      color: SCColors.color_1B1C33
    ),);
  }

  /// content
  Widget contentWidget() {
    String contentString = content ?? '';
    return Text(contentString, textAlign: TextAlign.left, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(
        fontSize: SCFonts.f14,
        fontWeight: FontWeight.w400,
        color: SCColors.color_5E5E66
    ),);
  }
  
  /// arrow
  Widget arrowIcon() {
    return Image.asset(SCAsset.iconMineDetailGrey, width: 22.0, height: 22.0,);
  }

  /// cell点击
  clickAction() {
    if (onTap != null) {
      onTap?.call();
    }
  }
}