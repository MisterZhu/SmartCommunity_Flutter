
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smartcommunity/page/Mine/View/ToggleHouses/sc_my_house_item.dart';
import 'package:smartcommunity/utils/Router/sc_router_helper.dart';
import 'package:smartcommunity/utils/sc_utils.dart';

import '../../../constants/sc_asset.dart';
import '../../../constants/sc_colors.dart';
import '../../../constants/sc_fonts.dart';
import '../GetXController/sc_current_house_controller.dart';
import '../GetXController/sc_my_house_controller.dart';
import '../GetXController/sc_toggle_houses_controller.dart';
import '../Model/sc_my_house_model.dart';
import '../View/ToggleHouses/sc_current_house_info_item.dart';
import '../View/ToggleHouses/sc_current_house_review_item.dart';
import '../View/ToggleHouses/sc_message_tab.dart';
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

  SCMyHouseController myRoomNumberState = Get.put(SCMyHouseController());
  SCCurrentHouseController currentHouseState = Get.put(SCCurrentHouseController());

  double tabItemWidth = 140;
  double tabItemHeight = 44.0;
  int number = 0;
  List<Widget> tabList = [];

  final double scale = 1.0;

  late TabController tabController;

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
    });

    loadMyHouseData();
    loadCurrentHouseBasicData();
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
                Column(
                  children: [
                    Expanded(child: myHouseListView()),
                    myRoomNumberBottomItem()
                  ],
                ),
                Column(
                  children: [
                    Expanded(child: currentHouseListView()),
                    currentHouseBottomItem()
                  ],
                ),
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
        numberColor: Colors.white,
        numberText: number > 99 ? '99+' : number.toString(),);
    });
  }

  /// 我的房号listView
  Widget myHouseListView() {
    return GetBuilder<SCMyHouseController>(builder: (state) {
      return ListView.separated(
          padding: const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
          itemBuilder: (BuildContext context, int index) {
            SCMyHouseModel model = state.dataList[index];
            return SCMyHouseItem(model: model,);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 0.5,);
          },
          itemCount: state.dataList.length);
    });
  }

  /// 底部新增房号按钮
  Widget myRoomNumberBottomItem() {
    return Container(
      color: SCColors.color_FFFFFF,
      width: double.infinity,
      height: 54.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 7.0),
        child: Container(
          height: 40.0,
          decoration: BoxDecoration(
              color: SCColors.color_FF6C00,
              borderRadius: BorderRadius.circular(4.0)),
          child: CupertinoButton(
              padding: EdgeInsets.zero,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(SCAsset.iconMineHouseAdd, width: 14.0, height: 14.0,),
                  const SizedBox(width: 10.0,),
                  const Text(
                    '新增房号',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      color: SCColors.color_FFFFFF,
                    ),
                  ),
                ],
              ),
              onPressed: () {
                /// 去新增房号
                var params = {
                  'communityId': '',
                  'houseId': '',
                  'valueList': ['', '', '', ''],
                  'isFromLogin': false
                };
                SCRouterHelper.codePage(5002, params);
              }),
        ),
      ),
    );
  }

  /// 当前房屋listView
  Widget currentHouseListView() {
    return GetBuilder<SCCurrentHouseController>(builder: (state) {
      return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return SCCurrentHouseInfoItem(infoModel: state.infoModel);
            } else {
              return SCCurrentHouseReviewItem(reviewList: state.selectReviewIndex == 0 ? state.infoModel.adoptMembers : state.infoModel.underReviewMembers);
            }
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 12,
            );
          },
          itemCount: 2);
    });
  }

  /// 当前房屋底部解除绑定按钮
  Widget currentHouseBottomItem() {
    return Container(
      color: SCColors.color_FFFFFF,
      width: double.infinity,
      height: 54.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 7.0),
        child: Container(
          height: 40.0,
          decoration: BoxDecoration(
              color: SCColors.color_FF6C00,
              borderRadius: BorderRadius.circular(4.0)),
          child: CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Text(
                  '解除绑定',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: SCColors.color_FFFFFF,
                  ),
              ),
              onPressed: () {

              }),
        ),
      ),
    );
  }

  loadMyHouseData() {
    SCMyHouseController state = Get.find<SCMyHouseController>();
    state.loadData();
  }

  /// 加载当前房屋 房屋信息
  loadCurrentHouseBasicData(){
    SCCurrentHouseController state = Get.find<SCCurrentHouseController>();
    state.loadData();
  }
}