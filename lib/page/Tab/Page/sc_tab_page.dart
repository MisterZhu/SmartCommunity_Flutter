import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartcommunity/constants/sc_asset.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/page/Find/Page/sc_find_page.dart';
import 'package:smartcommunity/page/Home/Page/sc_home_page.dart';
import 'package:smartcommunity/page/Mine/Page/sc_mine_page.dart';
import 'package:smartcommunity/page/Service/Page/sc_service_page.dart';

import '../../../utils/sc_utils.dart';

/// tab-page

class SCTabPage extends StatefulWidget {
  @override
  SCTabState createState() => SCTabState();
}

class SCTabState extends State<SCTabPage> with TickerProviderStateMixin{
  late TabController tabController;
  late PageController pageController;
  int currentIndex = 0;
  List<Widget> pageList = [
    SCHomePage(),
    SCServicePage(),
    SCFindPage(),
    SCMinePage()
  ];
  List<BottomNavigationBarItem> tabbarItems = [
    BottomNavigationBarItem(
      icon: Image.asset(SCAsset.iconNormalHome),
      activeIcon: Image.asset(SCAsset.iconSelectedHome),
      label: '首页',
    ),
    BottomNavigationBarItem(
      icon: Image.asset(SCAsset.iconNormalService),
      activeIcon: Image.asset(SCAsset.iconSelectedService),
      label: '服务',
    ),
    BottomNavigationBarItem(
      icon: Image.asset(SCAsset.iconNormalFind),
      activeIcon: Image.asset(SCAsset.iconSelectedFind),
      label: '发现',
    ),
    BottomNavigationBarItem(
      icon: Image.asset(SCAsset.iconNormalMine),
      activeIcon: Image.asset(SCAsset.iconSelectedMine),
      label: '我的',
    )
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: tabbarItems.length, vsync: this);
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
    // TODO: implement build
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: this.pageController,
        children: this.pageList,
      ),
      bottomNavigationBar: Theme(
          data: ThemeData(
              brightness: Brightness.dark,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent),
          child: CupertinoTabBar(
            activeColor: SCColors.color_1B1C33,
            inactiveColor: SCColors.color_8A8A8A,
            items: this.tabbarItems,
            currentIndex: this.currentIndex,
            backgroundColor: Colors.white,
            onTap: tabbarTap,
          )),
    );
  }

  /*底部tabbar点击*/
  void tabbarTap(int index) {
    updateStatusBar(index);

    if (currentIndex != index) {
      setState(() {
        currentIndex = index;
        pageController.jumpToPage(index);
      });
    } else {
      // setState(() {
      //   changeTab();
      // });
    }
  }

  /// 更新状态栏
  updateStatusBar(int index) {
    if (index == 0) {
      SCUtils().changeStatusBarStyle(style: SystemUiOverlayStyle.light);
    } else if (index == 1) {
      SCUtils().changeStatusBarStyle(style: SystemUiOverlayStyle.dark);
    } else if (index == 2) {
      SCUtils().changeStatusBarStyle(style: SystemUiOverlayStyle.light);
    } else {
      SCUtils().changeStatusBarStyle(style: SystemUiOverlayStyle.dark);
    }
  }

  changeTab() {
    pageList = [
      SCHomePage(),
      SCMinePage()
    ];
    tabbarItems = [
      BottomNavigationBarItem(
        icon: Image.asset(SCAsset.iconNormalHome),
        activeIcon: Image.asset(SCAsset.iconSelectedHome),
        label: '首页',
      ),
      BottomNavigationBarItem(
        icon: Image.asset(SCAsset.iconNormalMine),
        activeIcon: Image.asset(SCAsset.iconSelectedMine),
        label: '我的',
      )
    ];

    tabController = TabController(length: tabbarItems.length, vsync: this);
  }
}