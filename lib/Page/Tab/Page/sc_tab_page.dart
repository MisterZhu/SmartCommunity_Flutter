import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import '../../../Utils/sc_utils.dart';
import '../GetXController/sc_tab_controller.dart';

/// tab-page

class SCTabPage extends StatefulWidget {
  @override
  SCTabState createState() => SCTabState();
}

class SCTabState extends State<SCTabPage> with TickerProviderStateMixin{

  SCTabController state = Get.put(SCTabController());

  late TabController tabController;
  late PageController pageController;
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: state.tabbarItems.length, vsync: this);
    pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SCTabController>(builder: (state){
      return Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: state.pageList,
        ),
        bottomNavigationBar: Theme(
          data: ThemeData(
              brightness: Brightness.dark,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent),
          child: CupertinoTabBar(
            activeColor: SCColors.color_1B1D33,
            inactiveColor: SCColors.color_5E5F66,
            items: state.tabbarItems,
            currentIndex: currentIndex,
            backgroundColor: Colors.white,
            onTap: tabbarTap,
          )),
      );
    });
  }

  /*底部tabbar点击*/
  void tabbarTap(int index) {
    updateStatusBar(index);
    if (currentIndex != index) {
      if (!SCScaffoldManager.instance.isLogin) {
        SCRouterHelper.presentLoginPage();
        return;
      }
      setState(() {
        currentIndex = index;
        pageController.jumpToPage(index);
      });
    }
  }

  /// 更新状态栏
  updateStatusBar(int index) {
    if (index == 0) {
      SCUtils().changeStatusBarStyle(style: SystemUiOverlayStyle.light);
    } else if (index == 1) {
      SCUtils().changeStatusBarStyle(style: SystemUiOverlayStyle.dark);
    } else if (index == 2) {
      SCUtils().changeStatusBarStyle(style: SystemUiOverlayStyle.dark);
    } else {
      SCUtils().changeStatusBarStyle(style: SystemUiOverlayStyle.dark);
    }
  }

}