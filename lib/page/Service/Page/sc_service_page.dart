
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/constants/sc_key.dart';
import 'package:smartcommunity/network/sc_config.dart';
import 'package:smartcommunity/page/Service/GetXController/sc_service_controller.dart';
import 'package:smartcommunity/utils/Router/sc_router_path.dart';
import 'package:smartcommunity/utils/sc_sp_utils.dart';

import '../../../constants/sc_colors.dart';
import '../../../constants/sc_default_value.dart';
import '../../../constants/sc_fonts.dart';
import '../../../constants/sc_h5.dart';
import '../../../skin/Tools/sc_scaffold_manager.dart';
import '../../../utils/Router/sc_router_helper.dart';
import '../Model/sc_service_module_model.dart';
import '../View/sc_service_listView1.dart';
import '../View/sc_service_listView2.dart';

/// 服务-page

class SCServicePage extends StatefulWidget {
  @override
  SCServiceState createState() => SCServiceState();
}

class SCServiceState extends State<SCServicePage> with AutomaticKeepAliveClientMixin{
  SCServiceController state = Get.put(SCServiceController());

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: titleItem(),
        backgroundColor: SCColors.color_FFFFFF,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: body(),
    );
  }

  /// title
  Widget titleItem() {
    return const Text('全部应用', style: TextStyle(
        fontSize: SCFonts.f16,
        fontWeight: FontWeight.bold,
        color: SCColors.color_1B1C33
    ),);
  }

  /// body
  Widget body() {
    return GetBuilder<SCServiceController>(builder: (state){
      return Container(
        width: double.infinity,
        height: double.infinity,
        color: SCColors.color_F6F6F6,
        child: skin(),
      );
    });
  }

  Widget skin() {
    return GetBuilder<SCServiceController>(builder: (state){
      if (state.skinStyle == 0) {
        return skin1();
      } else if(state.skinStyle == 1) {
        return skin2();
      } else {
        return skin1();
      }
    });
  }

  /// skin1
  Widget skin1() {
    return SCServiceListView1(
      appList: state.moduleList,
      itemTapAction: (title) {
        /// 应用icon点击跳转
        itemDetail(title);
      }
    );
  }

  /// skin2
  Widget skin2() {
    /// list数组要用深拷贝List.from，再处理数组，否则会影响state.list里的数据
    List<SCServiceModuleModel> list = List.from(state.moduleList);
    if (list.contains(state.regularModuleModel)) {
      list.remove(state.regularModuleModel);
    }
    return SCServiceListView2(
      model: state.regularModuleModel,
      appList: list,
      itemTapAction: (title){
        /// 应用icon点击跳转
        itemDetail(title);
      },
    );
  }

  /// 获取数据，接口没返回数据，暂时用本地测试数据
  loadData() {
    SCServiceController state = Get.find<SCServiceController>();
    //state.loadAppListData();
    state.loadTestData();
  }

  /// 应用详情
  itemDetail(String title) {
    if (title.contains('建信')) {// 建信租房
      String token = SCSpUtil.getString(SCKey.kJianXinRentingToken);
      String url = "";
      url = "${SCH5.jxRentingHomeUrl}?token=$token";
      SCRouterHelper.pathPage(SCRouterPath.webViewPath, {"title" : title, "url" : url});
    } else {
      String defCommunityId = SCScaffoldManager.instance.user.communityId ?? "";
      String token = SCScaffoldManager.instance.user.token ?? "";
      String defRoomId = SCScaffoldManager.instance.user.spaceId.toString();
      String url = "${SCConfig.getH5Url(SCH5.workOrderUrl)}?defCommunityId=$defCommunityId&Authorization=$token&defRoomId=$defRoomId&client=${SCDefaultValue.client}";
      SCRouterHelper.pathPage(SCRouterPath.webViewPath, {"title" : title, "url" : url});
    }
  }
}