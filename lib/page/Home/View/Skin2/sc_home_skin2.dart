import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/page/Home/GetXController/sc_home_controller2.dart';
import 'package:smartcommunity/page/Home/View/Skin2/sc_home_listview2.dart';
import 'package:smartcommunity/page/Home/View/Skin2/sc_home_navigation2.dart';
import 'package:smartcommunity/utils/sc_utils.dart';

import '../../../../constants/sc_asset.dart';

/// 首页第二套皮肤

class SCHomeSkin2 extends StatelessWidget {
  SCHomeSkin2({Key? key}) : super(key: key);

  double navHeight = 44.0 + SCUtils().getTopSafeArea();

  SCHomeController2 state = Get.find<SCHomeController2>();

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Stack(
      children: [topBG(), topNav(), listView()],
    );
  }

  /// 顶部背景图片
  Widget topBG() {
    return GetBuilder<SCHomeController2>(builder: (state){
      return Visibility(
          visible: !state.navigationSticky,
          child: Image.asset(
            SCAsset.homeSkin2TopBG,
            fit: BoxFit.fill,
            width: SCUtils().getScreenWidth(),
            height: state.topNavBGImageHeight,
          ));
    });
  }

  /// 顶部导航栏
  Widget topNav() {
    return Positioned(
      left: 0, right: 0, top: 0,
        height: navHeight,
        child: GetBuilder<SCHomeController2>(builder: (state){
          return SCHomeNavigation2(
            isSticky: state.navigationSticky,
            backgroundColor: state.navigationBackgroundColor,
          );
        }));
  }

  /// listView
  Widget listView() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(top: navHeight + 5.0),
      child: GetBuilder<SCHomeController2>(builder: (state){
       return SCHomeListView2(
          scrollFunction: (value) {
            state.changeNavigationState(offset: value);
          },
       );
      }),
    );
  }
}
