import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/Home/GetXController/sc_home_controller2.dart';
import 'package:smartcommunity/Page/Home/View/Skin2/sc_home_listview2.dart';
import 'package:smartcommunity/Page/Home/View/Skin2/sc_home_navigation2.dart';
import 'package:smartcommunity/Utils/Router/sc_router_path.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';
import '../../../../Constants/sc_asset.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Utils/Router/sc_router_helper.dart';

/// 首页第二套皮肤

class SCHomeSkin2 extends StatelessWidget {
  SCHomeSkin2({Key? key,this.getUserInfoAction}) : super(key: key);

  double navHeight = 44.0 + SCUtils().getTopSafeArea();
  /// 获取用户信息
  final Function? getUserInfoAction;
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
          child: state.imageUrl.isNotEmpty ? Image.network(
            state.imageUrl,
            fit: BoxFit.fill,
            width: SCUtils().getScreenWidth(),
            height: state.topNavBGImageHeight,
          ) : Image.asset(
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
            unreadNum: SCScaffoldManager.instance.unreadMessageCount,
            roomTitle: state.communityName,
            isSticky: state.navigationSticky,
            backgroundColor: state.navigationBackgroundColor,
            searchAction: () {
              SCLoadingUtils.developing();
            },
            scanAction: () {
              SCRouterHelper.pathPage(SCRouterPath.scanPath, null);
            },
            messageAction: () {
              SCRouterHelper.pathPage(SCRouterPath.messagePage, null);
            },
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
         dataList: state.listViewData,
          scrollFunction: (value) {
            state.changeNavigationState(offset: value);
          },
         getUserInfoAction: () {
           getUserInfoAction?.call();
         },
         refreshAction: () {
           getUserInfoAction?.call();
         },
       );
      }),
    );
  }
}
