/// 首页-page
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/page/Home/GetXController/sc_home_controller.dart';
import 'package:smartcommunity/page/Home/GetXController/sc_home_controller1.dart';
import 'package:smartcommunity/page/Home/GetXController/sc_home_controller2.dart';
import 'package:smartcommunity/page/Home/View/sc_home_float_login.dart';
import 'package:smartcommunity/skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/utils/sc_utils.dart';
import '../../Service/GetXController/sc_service_controller.dart';
import '../View/Skin1/sc_home_skin1.dart';
import '../View/Skin2/sc_home_skin2.dart';

class SCHomePage extends StatefulWidget {
  @override
  SCHomeState createState() => SCHomeState();
}

class SCHomeState extends State<SCHomePage> with AutomaticKeepAliveClientMixin {
  SCHomeController state = Get.put(SCHomeController());
  SCHomeController1 state1 = Get.put(SCHomeController1());
  SCHomeController2 state2 = Get.put(SCHomeController2());
  SCServiceController service = Get.put(SCServiceController());

  @override
  Widget build(BuildContext context) {
    return body();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  dispose() {
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    SCUtils().changeStatusBarStyle(style: SystemUiOverlayStyle.light);
    if (SCScaffoldManager.instance.user.communityName != null) {
      state1.communityName = SCScaffoldManager.instance.user.communityName!;
      state2.communityName = SCScaffoldManager.instance.user.communityName!;
    } else {
      if (SCScaffoldManager.instance.user.token != null) {
        state1.communityName = '请选择项目';
        state2.communityName = '请选择项目';
      } else {
        state1.communityName = '请登录';
        state2.communityName = '请登录';
      }
    }
  }

  /// body
  Widget body() {
    return AnnotatedRegion(value: SystemUiOverlayStyle.light, child: Scaffold(
      body: Container(
        color: SCColors.color_F5F5F5,
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            skin(),
            SCHomeFloatLogin(),
          ],
        ),
      ),
    ));
  }

  Widget skin() {
    return GetBuilder<SCHomeController>(builder: (state){
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
    return const SCHomeSkin1();
  }

  /// skin2
  Widget skin2() {
    return SCHomeSkin2();
  }

}
