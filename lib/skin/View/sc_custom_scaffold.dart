
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/sc_colors.dart';
import '../GetXController/sc_scaffold_controller.dart';

class SCCustomScaffold extends StatelessWidget {
  /*body*/
  late Widget body;

  /*是否隐藏返回按钮*/
  late bool showBackIcon;

  /*标题*/
  late String title;

  /*标题是否居中*/
  late bool centerTitle;

  late double? elevation;

  /*是否显示背景图片*/
  late bool showBackgroundImage;

  /*背景图片url*/
  late String backgroundImageUrl;

  /*自定义title-widget*/
  Widget? customTitleWidget;

  /*NavBackgroundColor*/
  Color? navBackgroundColor;

  /*title-style*/
  TextStyle? textStyle;

  /*leading*/
  Widget? leading;

  /*leading宽度 默认56*/
  double? leadingWidth;

  List<Widget>? actions;

  SCCustomScaffold(
      {Key? key,
        required this.body,
        this.showBackIcon = true,
        this.title = '',
        this.centerTitle = false,
        this.showBackgroundImage = false,
        this.backgroundImageUrl = '',
        this.navBackgroundColor,
        this.textStyle,
        this.leading,
        this.elevation,
        this.leadingWidth,
        this.actions,
        this.customTitleWidget})
      : super(key: key);

  final state = Get.find<SCCustomScaffoldController>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder<SCCustomScaffoldController>(builder: (state) {
      return Scaffold(
        appBar: AppBar(
          title: getTitleWidget(),
          centerTitle: centerTitle,
          iconTheme: IconThemeData(
            color: state.backIconColor,
          ),
          backgroundColor: getNavBackgroundColor(),
          systemOverlayStyle: state.statusBarStyle,
          automaticallyImplyLeading: showBackIcon,
          flexibleSpace: getNavBackgroundImage(),
          elevation: elevation,
          leading: leading,
          leadingWidth: leadingWidth,
          actions: actions,
        ),
        body: body,
        backgroundColor: SCColors.color_FFFFFF,
      );
    });
  }

  /*Nav背景图片*/
  Widget getNavBackgroundImage() {
    return showBackgroundImage
        ? (backgroundImageUrl.contains('http')
        ? CachedNetworkImage(
      imageUrl: backgroundImageUrl,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.fill,
    )
        : Image.asset(
      backgroundImageUrl,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    ))
        : const SizedBox();
  }

  /*Nav背景颜色*/
  Color getNavBackgroundColor() {
    if (showBackgroundImage) {
      return Colors.transparent;
    } else {
      return navBackgroundColor ?? state.primaryColor;
    }
  }

  /*title-widget*/
  Widget getTitleWidget() {
    return customTitleWidget ??
        Text(
          title,
          style: textStyle ?? TextStyle(color: state.titleColor),
        );
  }
}
