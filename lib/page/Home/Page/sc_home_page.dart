/// 首页-page
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/page/Home/GetXController/sc_home_controller1.dart';
import 'package:smartcommunity/page/Home/GetXController/sc_home_controller2.dart';
import 'package:smartcommunity/utils/sc_utils.dart';

import '../View/Skin1/sc_home_skin1.dart';

class SCHomePage extends StatefulWidget {
  const SCHomePage({Key? key}) : super(key: key);

  @override
  SCHomeState createState() => SCHomeState();
}

class SCHomeState extends State<SCHomePage> with AutomaticKeepAliveClientMixin {
  SCHomeController1 state1 = Get.put(SCHomeController1());
  SCHomeController2 state2 = Get.put(SCHomeController2());

  @override
  Widget build(BuildContext context) {
    return body();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  initState() {
    super.initState();
    SCUtils().changeStatusBarStyle(style: SystemUiOverlayStyle.light);
  }

  /// body
  Widget body() {
    return Scaffold(
      body: Container(
        color: SCColors.color_F5F5F5,
        width: double.infinity,
        height: double.infinity,
        child: skin1(),
      ),
    );
  }

  /// skin1
  Widget skin1() {
    return const SCHomeSkin1();
  }

}
