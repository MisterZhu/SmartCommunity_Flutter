/// 首页-page
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/constants/sc_asset.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/constants/sc_type_define.dart';
import 'package:smartcommunity/page/Home/GetXController/sc_home_controller.dart';
import 'package:smartcommunity/page/Home/View/sc_home_listview.dart';
import 'package:smartcommunity/page/Home/View/sc_home_navigation.dart';

class SCHomePage extends StatefulWidget {
  const SCHomePage({Key? key}) : super(key: key);

  @override
  SCHomeState createState() => SCHomeState();
}

class SCHomeState extends State<SCHomePage> with AutomaticKeepAliveClientMixin {
  SCHomeController state = Get.find<SCHomeController>();

  @override
  Widget build(BuildContext context) {
    return body();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  initState() {
    super.initState();
  }

  /// body
  Widget body() {
    return Scaffold(
      body: Container(
        color: SCColors.color_F5F5F5,
        width: double.infinity,
        height: double.infinity,
        child: stack(),
      ),
    );
  }

  /// body-stack
  Widget stack() {
    return Stack(
      children: [
        listView(),
        navigation(),
      ],
    );
  }

  /// listview
  Widget listView() {
    List dataList = [
      /// banner
      {'type': SCTypeDefine.SC_HOME_TYPE_BANNER, 'data': []},

      /// 应用列表
      {'type': SCTypeDefine.SC_HOME_TYPE_ALLITEMS, 'data': []},

      /// 图片
      {'type': SCTypeDefine.SC_HOME_TYPE_IMAGE, 'data': []},

      /// 热门活动
      {'type': SCTypeDefine.SC_HOME_TYPE_ACTIVITY, 'data': []},

      /// 精选商家
      {'type': SCTypeDefine.SC_HOME_TYPE_FEATURE, 'data': []},

      /// 网格图片
      {'type': SCTypeDefine.SC_HOME_TYPE_GRID, 'data': []},

      /// swiper广告图
      {'type': SCTypeDefine.SC_HOME_TYPE_SWIPER, 'data': []},

      /// swiper广告图
      {'type': SCTypeDefine.SC_HOME_TYPE_SWIPER, 'data': []},

      /// 精选商家
      {'type': SCTypeDefine.SC_HOME_TYPE_FEATURE, 'data': []},

      /// 精选资讯
      {'type': SCTypeDefine.SC_HOME_TYPE_NEWS, 'data': []},

      /// 其他
      {'type': 1001, 'data': []},

      /// 其他
      {'type': 1001, 'data': []},

      /// 其他
      {'type': 1001, 'data': []},

      /// 其他
      {'type': 1001, 'data': []},

      /// 其他
      {'type': 1001, 'data': []},

      /// 其他
      {'type': 1001, 'data': []},
    ];

    return GetBuilder<SCHomeController>(builder: (state) {
      String bannerBackgroundImageUrl = state.allBannerBGList.isEmpty
          ? SCAsset.homeBannerBG1
          : state.allBannerBGList[state.bannerCurrentIndex];
      return SCHomeListView(
        dataList: dataList,
        bannerBGScale: state.bannerBGScale,
        bannerScale: state.bannerScale,
        bannerList: state.allBannerList,
        bannerCurrentIndex: state.bannerCurrentIndex,
        bannerBackgroundImageUrl: bannerBackgroundImageUrl,
        scrollFunction: (double offset) {
          state.changeNavigationState(offset: offset);
        },
      );
    });
  }

  /// navigation
  Widget navigation() {
    return GetBuilder<SCHomeController>(builder: (state) {
      return SCHomeNavigation(
        opacity: state.opacity,
        backgroundColor: state.navigationBackgroundColor,
        isSticky: state.navigationSticky,
        stickyColor: state.navigationStickyColor,
        normalColor: state.navigationNormalColor,
      );
    });
  }
}
