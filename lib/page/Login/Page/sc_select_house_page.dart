import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_select_house_controller.dart';
import 'package:smartcommunity/page/Login/Model/demo_sc_house_community_model.dart';
import 'package:smartcommunity/page/Login/View/SelectHouse/sc_select_house_building_page_view.dart';
import 'package:smartcommunity/skin/View/sc_custom_scaffold.dart';

import '../../../constants/sc_colors.dart';
import '../../../constants/sc_fonts.dart';
import '../View/SelectHouse/sc_select_house_community_page_view.dart';

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
  /// 苑级别的list
  List<DemoSCHouseCommunityModel> houseCommunityList = [];
  SCSelectHouseController state = Get.put(SCSelectHouseController());
  late PageController pageController;
  List<Widget> widgetList = [SCSelectHouseCommunityPageView(), SCSelectHouseBuildingPageView()];

  @override
  void initState() {
    super.initState();
    loadData();
    pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  /// 加载数据
  void loadData() {
    /// 构建静态数据
    for (int i = 0; i <= 5; i++) {
      DemoSCHouseCommunityModel demoSCHouseCommunityModel =
          DemoSCHouseCommunityModel(
              id: '$i', name: '这是第$i个苑', isChecked: false);
      houseCommunityList.add(demoSCHouseCommunityModel);
    }
    state.updateHouseCommunityList(houseCommunityList);
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
      );
    });
  }

  /// 内容
  Widget contentWidget() {
    return PageView.builder(
      itemCount: widgetList.length,
      scrollDirection: Axis.horizontal,
      reverse: false,
      controller: pageController,
      physics: const PageScrollPhysics(parent: ClampingScrollPhysics()),
      itemBuilder: ((context, index) {
        return GestureDetector(
          child: widgetList[index]
        );
      }),
      onPageChanged: (index){

      },
    );
  }

  /// 标题textStyle
  TextStyle _textStyle() {
    return const TextStyle(
        fontSize: SCFonts.f16,
        fontWeight: FontWeight.bold,
        color: SCColors.color_1B1C33);
  }
}
