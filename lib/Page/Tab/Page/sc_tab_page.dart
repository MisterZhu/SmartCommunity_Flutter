import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Page/Find/Page/sc_find_page.dart';
import 'package:smartcommunity/Page/Home/Page/sc_home_page.dart';
import 'package:smartcommunity/Page/Mine/Page/sc_mine_page.dart';
import 'package:smartcommunity/Page/Service/Page/sc_service_page.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import 'package:smartcommunity/Utils/Router/sc_router_path.dart';
import '../../../Network/sc_config.dart';
import '../../../Skin/Model/sc_home_visitor_decoration_model.dart';
import '../../../Skin/Model/sc_user.dart';
import '../../../Utils/sc_utils.dart';

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
    // SCServicePage(),
    // SCFindPage(),
    SCMinePage()
  ];
  List<BottomNavigationBarItem> tabbarItems = [
    BottomNavigationBarItem(
      icon: Image.asset(SCAsset.iconNormalHome),
      activeIcon: Image.asset(SCAsset.iconSelectedHome),
      label: '首页',
    ),
    // BottomNavigationBarItem(
    //   icon: Image.asset(SCAsset.iconNormalService),
    //   activeIcon: Image.asset(SCAsset.iconSelectedService),
    //   label: '服务',
    // ),
    // BottomNavigationBarItem(
    //   icon: Image.asset(SCAsset.iconNormalFind),
    //   activeIcon: Image.asset(SCAsset.iconSelectedFind),
    //   label: '发现',
    // ),
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

    // if (SCScaffoldManager.instance.isLogin) {
    //
    // } else {
      SCHomeVisitorDecorationModel visitorDecorationModel = SCScaffoldManager.instance.visitorDecorationModel;
      List<NavigationList>? tabList = visitorDecorationModel.overallDecoration?.bottomNavigation?.navigationList;
      if (tabList != null) {
        pageList = [];
        tabbarItems = [];
        for (NavigationList tab in tabList) {
          if (tab.title == '首页') {
            pageList.add(SCHomePage());
            String normalIcon =  SCAsset.iconNormalHome;
            if (tab.iconInfo?.unchecked != null) {
              normalIcon = SCConfig.getImageUrl(tab.iconInfo?.unchecked ?? '');
            }
            String selectIcon =  SCAsset.iconSelectedHome;
            if (tab.iconInfo?.checked != null) {
              selectIcon = SCConfig.getImageUrl(tab.iconInfo?.checked ?? '');
            }
            tabbarItems.add(BottomNavigationBarItem(
              icon: SCUtils.imageWidget(url: normalIcon),
              activeIcon: SCUtils.imageWidget(url: selectIcon),
              label: '首页',
            ));
          } else if (tab.title == '服务') {
            pageList.add(SCServicePage());
            String normalIcon =  SCAsset.iconNormalService;
            if (tab.iconInfo?.unchecked != null) {
              normalIcon = SCConfig.getImageUrl(tab.iconInfo?.unchecked ?? '');
            }
            String selectIcon =  SCAsset.iconSelectedService;
            if (tab.iconInfo?.checked != null) {
              selectIcon = SCConfig.getImageUrl(tab.iconInfo?.checked ?? '');
            }
            tabbarItems.add(BottomNavigationBarItem(
              icon: SCUtils.imageWidget(url: normalIcon),
              activeIcon: SCUtils.imageWidget(url: selectIcon),
              label: '服务',
            ));
          } else if (tab.title == '发现') {
            pageList.add(SCFindPage());
            String normalIcon =  SCAsset.iconNormalFind;
            if (tab.iconInfo?.unchecked != null) {
              normalIcon = SCConfig.getImageUrl(tab.iconInfo?.unchecked ?? '');
            }
            String selectIcon =  SCAsset.iconSelectedFind;
            if (tab.iconInfo?.checked != null) {
              selectIcon = SCConfig.getImageUrl(tab.iconInfo?.checked ?? '');
            }
            tabbarItems.add(BottomNavigationBarItem(
              icon: SCUtils.imageWidget(url: normalIcon),
              activeIcon: SCUtils.imageWidget(url: selectIcon),
              label: '发现',
            ));
          } else if (tab.title == '我的') {
            pageList.add(SCMinePage());
            String normalIcon =  SCAsset.iconNormalMine;
            if (tab.iconInfo?.unchecked != null) {
              normalIcon = SCConfig.getImageUrl(tab.iconInfo?.unchecked ?? '');
            }
            String selectIcon =  SCAsset.iconSelectedMine;
            if (tab.iconInfo?.checked != null) {
              selectIcon = SCConfig.getImageUrl(tab.iconInfo?.checked ?? '');
            }
            tabbarItems.add(BottomNavigationBarItem(
              icon: SCUtils.imageWidget(url: normalIcon),
              activeIcon: SCUtils.imageWidget(url: selectIcon),
              label: '我的',
            ));
          }
        }
    //  }
    }
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
        controller: pageController,
        children: pageList,
      ),
      bottomNavigationBar: Theme(
          data: ThemeData(
              brightness: Brightness.dark,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent),
          child: CupertinoTabBar(
            activeColor: SCColors.color_1B1D33,
            inactiveColor: SCColors.color_5E5F66,
            items: tabbarItems,
            currentIndex: currentIndex,
            backgroundColor: Colors.white,
            onTap: tabbarTap,
          )),
    );
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
      SCUtils().changeStatusBarStyle(style: SystemUiOverlayStyle.dark);
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