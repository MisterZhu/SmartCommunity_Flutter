/// 首页皮肤1-GetxController
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/constants/sc_asset.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/constants/sc_enum.dart';
import 'package:smartcommunity/constants/sc_skin_value.dart';
import 'package:smartcommunity/page/Home/Model/sc_home_news_model.dart';
// import 'package:image_cropper/image_cropper.dart';

class SCHomeController1 extends GetxController {

  /// 导航栏不透明度
  double opacity = 1.0;

  /// 导航栏默认offset
  final double navigationOffset = 120.0;

  /// 导航栏背景颜色,默认白色
  Color navigationBackgroundColor = SCColors.color_FE8947;
  /// 导航栏状态，是否置顶
  bool navigationSticky = false;
  /// 导航栏置顶颜色,默认黑色
  Color navigationStickyColor = Colors.white;
  /// 未置顶颜色,默认白色
  Color navigationNormalColor = Colors.white;

  /// 是否在下拉刷新中
  bool isRefreshing = false;

  /// banner背景大图比例
  double bannerBGScale = 750.0 / 544.0;

  /// banner比例
  double bannerScale = 686 / 280.0;

  /// banner当前index
  int bannerCurrentIndex = 0;

  EasyRefreshController refreshController = EasyRefreshController();

  /// 所有应用
  List allItemsList = [
    SCAsset.iconItem1,
    SCAsset.iconItem2,
    SCAsset.iconItem3,
    SCAsset.iconItem4,
    SCAsset.iconItem5,
    SCAsset.iconItem6,
    SCAsset.iconItem7,
    SCAsset.iconItem8,
    SCAsset.iconItem9,
    SCAsset.iconItem10,
  ];
  /// 所有banner
  List allBannerList = [
    SCAsset.homeBanner1,
    SCAsset.homeBanner2,
    SCAsset.homeBanner3
  ];

  /// 所有banner的背景图片
  List allBannerBGList = [
    SCAsset.homeBannerBG1,
    SCAsset.homeBannerBG2,
    SCAsset.homeBannerBG3
  ];

  /// 活动图片list
  List allActivityImageList = [
    SCAsset.homeActivity3,
    SCAsset.homeActivity1,
    SCAsset.homeActivity2,
    SCAsset.homeActivity3,
    SCAsset.homeActivity1,
    SCAsset.homeActivity2,
    SCAsset.homeActivity3,
    SCAsset.homeActivity1,
    SCAsset.homeActivity2,
  ];

  /// 资讯list
  List<SCHomeNewsModel>? allNewsList;

  /// 精选商家cell样式1
  late SCHomeFeatureStyle homeFeatureStyle1;

  /// 精选商家cell样式1
  late SCHomeFeatureStyle homeFeatureStyle2;

  /// siper-水平间距
  double swiper_horizontalPadding = 16.0;
  /// siper-圆角
  double swiper_radius = 6.0;
  /// siper-imageScale
  double swiper_scale = 686.0 / 260.0;
  /// siper-pagenation默认颜色
  Color swiper_normal_color = Colors.grey;
  /// siper-pagenation选中颜色
  Color swiper_active_color = Colors.orange;

  @override
  void onInit() {
    super.onInit();
    allNewsList = List.from(homeNewsList).map((e) => SCHomeNewsModel.fromJson(e)).toList();
    homeFeatureStyle1 = SCHomeFeatureStyle.featureStyle1;
    homeFeatureStyle2 = SCHomeFeatureStyle.featureStyle2;
  }

  /// 修改导航栏透状态
  void changeNavigationState({double offset = 0.0}) {
    if (isRefreshing) {
      opacity = 0;
    }else {
      if (offset < 0.0) {
        opacity = 0;
      } else {
        opacity = 1.0;
      }
    }
    if (offset > navigationOffset) {
      navigationSticky = true;
    }else {
      navigationSticky = false;
    }
    update();
  }

  /// 修改bannerIndex
  void changeBannerIndex({int index = 0}) {
    bannerCurrentIndex = index;
    update();
  }

  /// 裁剪图片
  void croperImage() {

  }

  /// 重置数据
  void resetAllData() {
    opacity = 1;
    navigationBackgroundColor = SCColors.color_FE8947;
    navigationSticky = false;
    navigationStickyColor = Colors.white;
    navigationNormalColor = Colors.white;
    isRefreshing = false;
    bannerCurrentIndex = 0;
    update();
  }
}