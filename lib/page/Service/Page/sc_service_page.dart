
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/page/Service/GetXController/sc_service_controller.dart';

import '../../../constants/sc_colors.dart';
import '../../../constants/sc_default_value.dart';
import '../../../constants/sc_fonts.dart';
import '../../../constants/sc_h5.dart';
import '../../../skin/Tools/sc_scaffold_manager.dart';
import '../../../utils/Router/sc_router_helper.dart';
import '../View/sc_service_listView.dart';

/// 服务-page

class SCServicePage extends StatefulWidget {
  @override
  SCServiceState createState() => SCServiceState();
}

class SCServiceState extends State<SCServicePage> with AutomaticKeepAliveClientMixin{
  SCServiceController state = Get.put(SCServiceController());

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

  /// body
  Widget body() {
    return GetBuilder<SCServiceController>(builder: (state){
      return Container(
        width: double.infinity,
        height: double.infinity,
        color: SCColors.color_F6F6F6,
        child: SCServiceListView(
          appList: state.appList,
          itemTapAction: (title){
           /// 应用点击跳转
            log('应用点击跳转');
            String defCommunityId = SCScaffoldManager.instance.user.communityId ?? "";
            String token = SCScaffoldManager.instance.user.token ?? "";
            String defRoomId = SCScaffoldManager.instance.user.spaceId.toString();
            String url = SCH5.workOrderUrl + "?" + "defCommunityId=" + defCommunityId + "&Authorization=" + token + "&defRoomId=" + defRoomId + "&client=" + SCDefaultValue.client;
            SCRouterHelper.codePage(20000, {"title" : title, "url" : url});
        },),
      );
    });
  }

  /// title
  Widget titleItem() {
    return const Text('全部应用', style: TextStyle(
        fontSize: SCFonts.f16,
        fontWeight: FontWeight.bold,
        color: SCColors.color_1B1C33
    ),);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  loadData() {
    SCServiceController state = Get.find<SCServiceController>();
    //state.loadAppListData();
  }
}