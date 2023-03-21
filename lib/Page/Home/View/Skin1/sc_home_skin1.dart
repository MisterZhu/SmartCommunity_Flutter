import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Utils/Permission/sc_permission_utils.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import 'package:smartcommunity/Utils/Router/sc_router_pages.dart';
import 'package:smartcommunity/Utils/Router/sc_router_path.dart';
import '../../../../Constants/sc_asset.dart';
import '../../../../Constants/sc_type_define.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../GetXController/sc_home_controller1.dart';
import '../../GetXController/sc_home_nav1_controller.dart';
import 'sc_home_listview1.dart';
import 'sc_home_navigation1.dart';

/// 首页第一套皮肤

class SCHomeSkin1 extends StatelessWidget {

  SCHomeSkin1({Key? key}) : super(key: key);

  final GlobalKey navigationKey = GlobalKey();

  SCHomeNav1Controller nav1State = Get.find<SCHomeNav1Controller>();

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    Widget navigationBar = navigation();
    Widget contentWidget = listView();
    return Stack(
      children: [
        contentWidget,
        navigationBar,
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
       //{'type': SCTypeDefine.SC_HOME_TYPE_IMAGE, 'data': []},

      /// 热门活动
      //{'type': SCTypeDefine.SC_HOME_TYPE_ACTIVITY, 'data': []},

      /// 精选商家
      //{'type': SCTypeDefine.SC_HOME_TYPE_FEATURE, 'data': []},

      // /// 网格图片 宽高1:1，1行
      //{'type': SCTypeDefine.SC_HOME_TYPE_GRID, 'data': []},

      //{'type': SCTypeDefine.SC_HOME_TYPE_GRID_GROUP, 'data': []},

      // /// swiper广告图
       //{'type': SCTypeDefine.SC_HOME_TYPE_SWIPER, 'data': []},

      /// swiper广告图
      //{'type': SCTypeDefine.SC_HOME_TYPE_SWIPER, 'data': []},

      /// 精选商家
      //{'type': SCTypeDefine.SC_HOME_TYPE_FEATURE, 'data': []},

      // /// 精选资讯
      // {'type': SCTypeDefine.SC_HOME_TYPE_NEWS, 'data': []},
    ];

    return GetBuilder<SCHomeController1>(builder: (state) {
      String bannerBackgroundImageUrl = state.allBannerBGList.isEmpty
          ? SCAsset.homeBannerBG1
          : state.allBannerBGList[state.bannerCurrentIndex];
      return SCHomeListView1(
        tabTitleList: state.tabTitleList,
        dataList: dataList,
        bannerBGScale: state.bannerBGScale,
        bannerScale: state.bannerScale,
        bannerList: state.allBannerList,
        bannerCurrentIndex: state.bannerCurrentIndex,
        bannerBackgroundImageUrl: bannerBackgroundImageUrl,
        navigationHeight: nav1State.navigationHeight,
        scrollFunction: (double offset) {
          // state.changeNavigationState(offset: offset);
          SCHomeNav1Controller nav1controller = Get.find<SCHomeNav1Controller>();
          nav1controller.changeNavigationState(offset: offset);
        },
      );
    });
  }

  /// navigation
  Widget navigation() {
    return GetBuilder<SCHomeNav1Controller>(builder: (state) {
      String communityName = '';
      if (SCScaffoldManager.instance.user.communityName != null) {
        communityName = SCScaffoldManager.instance.user.communityName ?? '';
      }
      return SCHomeNavigation1(
        key: navigationKey,
        roomTitle: communityName,
        titleMaxLength: state.titleMaxLength,
        opacity: state.opacity,
        backgroundColor: state.navigationBackgroundColor,
        isSticky: state.navigationSticky,
        stickyColor: state.navigationStickyColor,
        normalColor: state.navigationNormalColor,
        scanAction: () {
          SCPermissionUtils.scanCodeWithPrivacyAlert();
        },
        messageAction: () {
          SCRouterHelper.pathPage(SCRouterPath.messagePage, null);
        },
        searchAction: () {
          SCLoadingUtils.developing();
        },
      );
    });
  }
}

