import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/sc_asset.dart';
import '../../../../constants/sc_type_define.dart';
import '../../GetXController/sc_home_controller1.dart';
import 'sc_home_listview1.dart';
import 'sc_home_navigation1.dart';

/// 首页第一套皮肤

class SCHomeSkin1 extends StatelessWidget {

  const SCHomeSkin1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
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

    return GetBuilder<SCHomeController1>(builder: (state) {
      String bannerBackgroundImageUrl = state.allBannerBGList.isEmpty
          ? SCAsset.homeBannerBG1
          : state.allBannerBGList[state.bannerCurrentIndex];
      return SCHomeListView1(
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
    return GetBuilder<SCHomeController1>(builder: (state) {
      return SCHomeNavigation1(
        opacity: state.opacity,
        backgroundColor: state.navigationBackgroundColor,
        isSticky: state.navigationSticky,
        stickyColor: state.navigationStickyColor,
        normalColor: state.navigationNormalColor,
      );
    });
  }
}

