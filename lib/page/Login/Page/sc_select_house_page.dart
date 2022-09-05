import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/network/sc_http_manager.dart';
import 'package:smartcommunity/network/sc_url.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_select_house_data_controller.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_select_house_search_status_controller.dart.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_select_house_controller.dart';
import 'package:smartcommunity/page/Login/Model/SelectHouse/sc_select_house_block_model.dart';
import 'package:smartcommunity/page/Login/View/SelectHouse/block/sc_select_house_block_page_view.dart';
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

  /// 列表list
  List<ScSelectHouseModel> houseCommunityList = [];
  SCSelectHouseSearchStatusController searchStatusController =
      Get.put(SCSelectHouseSearchStatusController());
  SCSelectHouseDataController scSelectHouseController =
      Get.put(SCSelectHouseDataController());

  /// 导航list
  List<ScSelectHouseModel> navigatorList = [];

  late String communityId;
  late PageController pageController;
  List<Widget> widgetList = [
    SCSelectHouseBlockPageView(),
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
    communityId = params["communityId"];
    String communityName = params["communityName"];
    selectHouseController.updateCommunityId(communityId: communityId);

    // 缓存顶部导航栏数据
    ScSelectHouseModel scSelectHouseModel = ScSelectHouseModel(communityId: communityId, id: 0, name: communityName);
    navigatorList.clear();
    navigatorList.add(scSelectHouseModel);
    scSelectHouseController.updateNavigatorList(list: navigatorList);

    loadData();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  /// 加载数据
  void loadData() {
    SCHttpManager.instance.get(
        url: SCUrl.kGetSpaceNodesUrl,
        params: {'communityId': selectHouseController.communityId},
        success: (value) {
          List<ScSelectHouseModel> dataList = List<ScSelectHouseModel>.from(
              value.map((e) => ScSelectHouseModel.fromJson(e)).toList());
          print('print--> 获取苑数据===$dataList');

          scSelectHouseController.updateDataList(
              list: dataList == null ? [] : dataList);
        },
        failure: (value) {
          if (value['message'] != null) {
            String message = value['message'];
            SCToast.showTip(message);
          }
          scSelectHouseController.updateDataList(list: []);
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
    return GetBuilder<SCSelectHouseController>(builder: (state) {
      return Container(
        height: 54.0,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        alignment: Alignment.centerLeft,
        child: Text('慧享服务中心 > 慧享生活馆 > 幢 > 单元'),
        /*child: CustomScrollView(
          controller: null,
          slivers: [
            ListView(
              children: [
                _navigatorItem()
              ],
            )
          ],
        ),*/
      );
    });
  }

  _navigatorItem(){
    // List<Widget> widgetList = List();
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
