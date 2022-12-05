import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_type_define.dart';
import 'package:smartcommunity/Page/Mine/GetXController/sc_mine_controller.dart';
import 'package:smartcommunity/Page/Mine/View/sc_mine_listview.dart';
import 'package:smartcommunity/Page/Mine/View/sc_mine_navigation.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';

import '../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../Utils/Router/sc_router_helper.dart';
import '../../../Utils/Router/sc_router_path.dart';

/// 我的-page

class SCMinePage extends StatefulWidget {
  @override
  SCMineState createState() => SCMineState();
}

class SCMineState extends State<SCMinePage> with AutomaticKeepAliveClientMixin{
  SCMineController state = Get.put(SCMineController());

  @override
  Widget build(BuildContext context) {
    return body();
  }

  @override
  initState() {
    super.initState();
  }

  /// body
  Widget body() {
    return Scaffold(
      body: Container(
        color: SCColors.color_F5F5F5,
        width: double.infinity,
        height: double.infinity,
        child: stack(),
      ),
    );
  }

  /// body-stack
  Widget stack() {
    return Stack(
      children: [
        listView(),
        navigation(),
      ],
    );
  }

  /// listview
  Widget listView() {
    List dataList = [
      SCTypeDefine.SC_MINE_TYPE_HEADER,
      SCTypeDefine.SC_MINE_TYPE_CHANGERHOUSE,
      SCTypeDefine.SC_MINE_TYPE_SCORE,
      SCTypeDefine.SC_MINE_TYPE_WALLET,
      SCTypeDefine.SC_MINE_TYPE_PROPERTY,
      SCTypeDefine.SC_MINE_TYPE_SERVICE,
      10001,
    ];
    return GetBuilder<SCMineController>(builder: (state){
      return SCMineListView(
        user: SCScaffoldManager.instance.user,
        propertCurrentIndex: state.propertyCurrentIndex,
        dataList: dataList,
        scrollFunction: (double offset) {
          state.changeNavigationState(offset: offset);
        },
      );
    });
  }

  /// navigation
  Widget navigation() {
    return GetBuilder<SCMineController>(builder: (state) {
      return SCMineNavigation(
        opacity: state.opacity,
        backgroundColor: state.navigationBackgroundColor,
        isSticky: state.navigationSticky,
        itemColor: state.itemColor,
        settingAction: () {
            SCRouterHelper.pathPage(SCRouterPath.settingPath, null);
        },
      );
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
