import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smartcommunity/Constants/sc_enum.dart';
import 'package:smartcommunity/Page/Home/GetXController/sc_home_controller.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';
import '../../../Constants/sc_enum.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../Skin/Model/sc_user.dart';
import '../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../Utils/Router/sc_router_path.dart';
import '../GetXController/sc_current_house_controller.dart';
import '../GetXController/sc_my_house_controller.dart';
import '../GetXController/sc_toggle_houses_controller.dart';
import '../Model/sc_my_house_model.dart';
import '../View/ToggleHouses/sc_current_house_view.dart';
import '../View/ToggleHouses/sc_message_tab.dart';
import '../View/ToggleHouses/sc_my_house_view.dart';
import '../View/ToggleHouses/sc_normal_tab.dart';
import '../View/ToggleHouses/sc_tab_indicator.dart';

/// 切换房屋-page

class SCToggleHousesPage extends StatefulWidget {
  @override
  SCToggleHousesState createState() => SCToggleHousesState();
}

class SCToggleHousesState extends State<SCToggleHousesPage>
    with SingleTickerProviderStateMixin {
  SCToggleHousesController toggleHouseState = Get.put(SCToggleHousesController());

  SCMyHouseController myHouseState = Get.put(SCMyHouseController());
  SCCurrentHouseController currentHouseState = Get.put(SCCurrentHouseController());

  double tabItemWidth = 140;
  double tabItemHeight = 44.0;
  int number = 0;
  List<Widget> tabList = [];

  final double scale = 1.0;

  late TabController tabController;

  late bool hadLoadCurrentHouseData = false;

  @override
  initState() {
    super.initState();
    if (number > 0) {
      tabList.add(messageTabItem('我的房号', 0));
    } else {
      tabList.add(normalTabItem('我的房号', 0));
    }
    tabList.add(normalTabItem('当前房屋', 1));
    tabController = TabController(length: tabList.length, vsync: this);

    SCToggleHousesController state = Get.find<SCToggleHousesController>();
    tabController.addListener(() {
      int currentIndex = tabController.index;
      state.updateSelectIndex(currentIndex);
      if (currentIndex == 1 && hadLoadCurrentHouseData == false) {
        loadCurrentHouseBasicData();
        hadLoadCurrentHouseData = true;
      }
    });
    loadMyHouseData();
  }

  @override
  dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: titleItem(),
        backgroundColor: SCColors.color_FFFFFF,
        elevation: 0,
      ),
      body: body(),
    );
  }

  /// title
  Widget titleItem() {
    return const Text('我的房号', style: TextStyle(
        fontSize: SCFonts.f16,
        fontWeight: FontWeight.bold,
        color: SCColors.color_1B1C33
    ),);
  }

  /// body
  Widget body() {
    return Container(
      color: SCColors.color_F2F3F5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          tabBarItem(),
          Container(
            height: 0.5,
            color: SCColors.color_D7D8DB,
          ),
          Expanded(child: TabBarView(
              controller: tabController,
              children: [
                myHouseView(),
                currentHouseView(),
              ])
          ),
          Container(
            color: SCColors.color_FFFFFF,
            height: SCUtils().getBottomSafeArea(),
          )
        ],
      ),
    );
  }

  /// 我的房号页面
  Widget myHouseView() {
    return SCMyHouseView(
      changeHouseAction : (model) {
        showToggleConfirmDialog(model: model);
      },
      addHouseAction: () {
        /// 去新增房号
        var params = {
          'communityId': '',
          'houseId': '',
          'valueList': ['', '', '', ''],
          'type': SCSelectHouseLogicType.addHouse
        };
        SCRouterHelper.pathPage(SCRouterPath.addHousePagePath, params);
      },
    );
  }

  /// 当前房屋页面
  Widget currentHouseView() {
    return SCCurrentHouseView(
      unbindHouse : () {
        showUnbindConfirmDialog();
      },
    );
  }

  /// tabBarItem
  Widget tabBarItem() {
    return Container(
      color: SCColors.color_FFFFFF,
      alignment: Alignment.center,
      height: 44.0 * scale,
      child: PreferredSize(
          preferredSize: Size.fromHeight(40.0 * scale),
          child: Material(
            color: Colors.transparent,
            child: Theme(
                data: ThemeData(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent),
                child: TabBar(
                  controller: tabController,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: SCTabIndicator(borderSide: const BorderSide(width: 3.0, color: SCColors.color_FF6C00)),
                  indicatorColor: SCColors.color_FF6C00,
                  unselectedLabelColor: SCColors.color_5E5F66,
                  labelColor: SCColors.color_1B1D33,
                  indicatorWeight: 3.0,
                  labelStyle: TextStyle(fontSize: SCFonts.f14 * scale, fontWeight: FontWeight.w500),
                  unselectedLabelStyle: TextStyle(
                      fontSize: SCFonts.f14 * scale, fontWeight: FontWeight.w400),
                  tabs: tabList,
                )),
          )),
    );
  }

  /// 普通tab
  Widget normalTabItem(String title, int index) {
    return GetBuilder<SCToggleHousesController>(builder: (state) {
      TextStyle textStyle = TextStyle(
          fontSize: 14,
          fontWeight: state.selectIndex == index ? FontWeight.w500 : FontWeight.w400,
          color: state.selectIndex == index ? SCColors.color_1B1D33 : SCColors.color_5E5F66
      );
      return SCNormalTab(
          text: title,
          width: tabItemWidth,
          height: tabItemHeight,
          textStyle: textStyle);
    });
  }

  /// 带数字消息的tab
  Widget messageTabItem(String title, int index) {
    return GetBuilder<SCToggleHousesController>(builder: (state) {
      TextStyle textStyle = TextStyle(
          fontSize: 14,
          fontWeight: state.selectIndex == index ? FontWeight.w500 : FontWeight.w400,
          color: state.selectIndex == index ? SCColors.color_1B1C33 : SCColors.color_5E5F66
      );
      return SCMessageTab(text: title,
        width: tabItemWidth,
        height: tabItemHeight,
        textStyle: textStyle,
        circleColor: SCColors.color_FF4040,
        numberColor: SCColors.color_FFFFFF,
        numberText: number > 99 ? '99+' : number.toString(),);
    });
  }

  /// 加载我的房号列表数据
  loadMyHouseData() {
    myHouseState.loadMyHouseData();
  }

  /// 加载当前房屋 房屋信息
  loadCurrentHouseBasicData(){
    currentHouseState.loadCurrentHouseData();
  }

  /// 切换房屋确认弹窗
  showToggleConfirmDialog({required SCMyHouseModel model}) {
    SCDialogUtils.instance.showMiddleDialog(
      context: context,
      title: '是否切换至',
      content: model.spaceName,
      isNeedCloseDiaLog: true,
      customWidgetButtons: [
        defaultCustomButton(
            context,
            text: '取消',
            textColor: SCColors.color_1B1C33,
            fontWeight: FontWeight.w400),
        TextButton(
            onPressed: () {
              changeHouseAction(model: model);
              Navigator.of(context).pop();
            },
            child: const Text(
                '确定',
                style: TextStyle(
                    color: SCColors.color_FF6C00,
                    fontSize: SCFonts.f16)))
      ],
    );
  }

  /// 切换房屋
  changeHouseAction({required SCMyHouseModel model}) {
    /// 切换,把项目id存在用户信息里
    SCUser user = SCScaffoldManager.instance.getUserData();
    user.housingId = model.id;
    user.communityId = model.communityId;
    user.communityName = model.communityName;
    user.spaceId = model.spaceId;
    user.spaceName = model.spaceName;
    user.identityId = model.identityId;
    SCScaffoldManager.instance.cacheUserData(user.toJson());
    myHouseState.updateCurrentHousingId(model.id);
    /// 当前房号的信息也要重新获取
    loadCurrentHouseBasicData();
    /// 刷新首页房号信息
    SCHomeController homeController = Get.find<SCHomeController>();
    homeController.changeHouse(model: model);
  }

  /// 解绑房号确认弹窗
  showUnbindConfirmDialog() {
    SCDialogUtils.instance.showMiddleDialog(
      context: context,
      title: '解除绑定',
      content: '是否解绑当前房号？',
      isNeedCloseDiaLog: true,
      customWidgetButtons: [
        defaultCustomButton(
            context,
            text: '取消',
            textColor: SCColors.color_1B1C33,
            fontWeight: FontWeight.w400),
        TextButton(
            onPressed: () {
              unbindHouse();
              Navigator.of(context).pop();
            },
            child: const Text('确定',
                style: TextStyle(
                    color: SCColors.color_FF6C00, fontSize: SCFonts.f16)))
      ],
    );
  }

  /// 解绑房屋
  unbindHouse() {
    currentHouseState.unBindHouse(resultHandler: (status) {
      if (status == true) {
        /// 切换,把项目id存在用户信息里
        SCUser user = SCScaffoldManager.instance.getUserData();
        user.housingId = '';
        user.communityId = '';
        user.communityName = '';
        user.spaceId = 0;
        user.spaceName = '';
        user.identityId = '';
        SCScaffoldManager.instance.cacheUserData(user.toJson());
        /// 解绑房屋成功，刷新我的房号列表
        myHouseState.loadMyHouseData();
        myHouseState.updateCurrentHousingId('');
        /// 当前房号的信息也要重新获取
        loadCurrentHouseBasicData();
        /// 清空首页房号信息
        SCMyHouseModel model = SCMyHouseModel();
        SCHomeController homeController = Get.find<SCHomeController>();
        homeController.changeHouse(model: model);
        navigator?.pop();
      }
    });
  }

}