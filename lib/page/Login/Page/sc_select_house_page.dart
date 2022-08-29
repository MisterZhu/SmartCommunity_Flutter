import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/network/sc_http_manager.dart';
import 'package:smartcommunity/network/sc_url.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_select_house_block_controller.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_select_house_block_search_status_controller.dart.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_select_house_building_controller.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_select_house_building_search_status_controller.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_select_house_controller.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_select_house_room_controller.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_select_house_room_search_status_controller.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_select_house_unit_controller.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_select_house_unit_search_status_controller.dart';
import 'package:smartcommunity/page/Login/Model/SelectHouse/demo_sc_house_building_model.dart';
import 'package:smartcommunity/page/Login/Model/SelectHouse/demo_sc_house_room_model.dart';
import 'package:smartcommunity/page/Login/Model/SelectHouse/demo_sc_house_unit_model.dart';
import 'package:smartcommunity/page/Login/Model/SelectHouse/sc_select_house_block_model.dart';
import 'package:smartcommunity/page/Login/View/SelectHouse/block/sc_select_house_block_page_view.dart';
import 'package:smartcommunity/page/Login/View/SelectHouse/building/sc_select_house_building_page_view.dart';
import 'package:smartcommunity/page/Login/View/SelectHouse/room/sc_select_house_room_page_view.dart';
import 'package:smartcommunity/page/Login/View/SelectHouse/unit/sc_select_house_unit_page_view.dart';
import 'package:smartcommunity/skin/View/sc_custom_scaffold.dart';
import 'package:smartcommunity/utils/Toast/sc_toast.dart';

import '../../../constants/sc_colors.dart';
import '../../../constants/sc_fonts.dart';

/// Copyright (c), 浙江慧享信息科技有限公司
/// FileName: sc_select_house_page
/// Author: wang tao
/// Email: wangtao1@lvchengfuwu.com
/// Date: 2022/8/17 13:53
/// Description: 选择房号

class SCSelectHousePage extends StatefulWidget {
  const SCSelectHousePage({Key? key}) : super(key: key);

  @override
  State<SCSelectHousePage> createState() => _SCSelectHousePageState();
}

class _SCSelectHousePageState extends State<SCSelectHousePage> {
  SCSelectHouseController selectHouseController =
      Get.put(SCSelectHouseController());

  /// 苑级别的list
  List<ScSelectHouseBlockModel> houseCommunityList = [];
  SCSelectHouseBlockSearchStatusController blockSearchStatusState =
      Get.put(SCSelectHouseBlockSearchStatusController());
  SCSelectHouseBlockController scSelectHouseBlockController =
      Get.put(SCSelectHouseBlockController());

  /// 幢级别的list
  List<DemoSCHouseBuildingModel> buildingList = [];
  SCSelectHouseBuildingSearchStatusController
      scSelectHouseBuildingSearchStatusController =
      Get.put(SCSelectHouseBuildingSearchStatusController());
  SCSelectHouseBuildingController scSelectHouseBuildingController =
      Get.put(SCSelectHouseBuildingController());

  /// 单元级别的list
  List<DemoSCHouseUnitModel> unitList = [];
  SCSelectHouseUnitSearchStatusController
      scSelectHouseUnitSearchStatusController =
      Get.put(SCSelectHouseUnitSearchStatusController());
  SCSelectHouseUnitController scSelectHouseUnitController =
      Get.put(SCSelectHouseUnitController());

  /// 单元级别的list
  List<DemoSCHouseRoomModel> roomList = [];
  SCSelectHouseRoomSearchStatusController
      scSelectHouseRoomSearchStatusController =
      Get.put(SCSelectHouseRoomSearchStatusController());
  SCSelectHouseRoomController scSelectHouseRoomController =
      Get.put(SCSelectHouseRoomController());

  late PageController pageController;
  List<Widget> widgetList = [
    SCSelectHouseBlockPageView(),
    SCSelectHouseBuildingPageView(),
    SCSelectHouseUnitPageView(),
    SCSelectHouseRoomPageView()
  ];

  @override
  void initState() {
    super.initState();

    pageController = PageController(initialPage: 0);
    selectHouseController.initPageController(
        pageController: pageController, pageIndex: 0);
    // 获取上一个页面的参数
    var params = Get.arguments;
    print('print--> 上个页面传过来的参数:$params');
    String communityId = params["communityId"];
    selectHouseController.updateCommunityId(communityId: communityId);

    loadData();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  /// 加载数据
  void loadData() {
    /// 加载苑层级数据
    loadBlockData();

    /// 构建静态数据  幢
    for (int i = 0; i <= 22; i++) {
      DemoSCHouseBuildingModel demoSCHouseBuildingModel =
          DemoSCHouseBuildingModel(id: '$i', name: '这是第$i个幢', isChecked: false);
      buildingList.add(demoSCHouseBuildingModel);
    }
    scSelectHouseBuildingController.updateHouseBuildingList(list: buildingList);

    /// 构建静态数据  单元
    for (int i = 0; i <= 10; i++) {
      DemoSCHouseUnitModel demoSCHouseUnitModel =
          DemoSCHouseUnitModel(id: '$i', name: '这是第$i个单元', isChecked: false);
      unitList.add(demoSCHouseUnitModel);
    }
    scSelectHouseUnitController.updateHouseUnitList(list: unitList);

    /// 构建静态数据  房间
    for (int i = 0; i <= 10; i++) {
      DemoSCHouseRoomModel demoSCHouseRoomModel =
          DemoSCHouseRoomModel(id: '$i', name: '这是第$i个室', isChecked: false);
      roomList.add(demoSCHouseRoomModel);
    }
    scSelectHouseRoomController.updateRoomList(list: roomList);
  }

  /// 加载苑列表数据
  loadBlockData() {
    SCHttpManager.instance.get(
        url: SCUrl.kGetSpaceNodesUrl,
        params: {'communityId': selectHouseController.communityId},
        success: (value) {
          var data = value['records'];
          List<ScSelectHouseBlockModel> dataList =
              List<ScSelectHouseBlockModel>.from(data
                  .map((e) => ScSelectHouseBlockModel.fromJson(e))
                  .toList());
          print('print--> 获取苑数据===$dataList');

          /*scSelectHouseBlockController.updateHouseBlockList(
              list: dataList == null ? [] : dataList);*/
        },
        failure: (value) {
          if (value['message'] != null) {
            String message = value['message'];
            SCToast.showTip(message);
          }
          scSelectHouseBlockController.updateHouseBlockList(list: []);
        });
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        centerTitle: true,
        showBackIcon: true,
        navBackgroundColor: SCColors.color_FFFFFF,
        elevation: 0,
        textStyle: _textStyle(),
        title: '选择房号',
        body: _body());
  }

  /// body
  Widget _body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: Column(
        children: [
          // 导航栏
          navigatorBarWidget(),

          // 内容
          Expanded(child: contentWidget())
        ],
      ),
    );
  }

  /// 顶部导航栏  慧享服务中心 > 慧享生活馆 > 幢 > 单元
  Widget navigatorBarWidget() {
    return GetBuilder<SCSelectHouseBlockSearchStatusController>(
        builder: (state) {
      return Container(
        height: 54.0,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        alignment: Alignment.centerLeft,
        child: Text('慧享服务中心 > 慧享生活馆 > 幢 > 单元'),
      );
    });
  }

  /// 内容
  Widget contentWidget() {
    return GetBuilder<SCSelectHouseController>(builder: (state) {
      return PageView.builder(
        itemCount: widgetList.length,
        scrollDirection: Axis.horizontal,
        reverse: false,
        controller: state.pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: ((context, index) {
          return GestureDetector(child: widgetList[index]);
        }),
        onPageChanged: (index) {
          print('print--> $index');
        },
      );
    });
  }

  /// 标题textStyle
  TextStyle _textStyle() {
    return const TextStyle(
        fontSize: SCFonts.f16,
        fontWeight: FontWeight.bold,
        color: SCColors.color_1B1C33);
  }
}
