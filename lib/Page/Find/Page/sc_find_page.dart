import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Page/Home/GetXController/sc_home_controller2.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';
import '../../Home/View/Skin2/sc_home_skin2.dart';

/// 发现-page

class SCFindPage extends StatefulWidget {
  @override
  SCFindState createState() => SCFindState();
}

class SCFindState extends State<SCFindPage> {

  SCHomeController2 state = Get.put(SCHomeController2());

  @override
  Widget build(BuildContext context) {
    return body();
  }

  @override
  initState() {
    super.initState();
    SCUtils().changeStatusBarStyle(style: SystemUiOverlayStyle.light);
  }

  /// body
  Widget body() {
    return Scaffold(
      body: Container(
        alignment: Alignment.topLeft,
        color: SCColors.color_F5F5F5,
        width: double.infinity,
        height: double.infinity,
        child: skin2(),
      ),
    );
  }

  /// skin2
  Widget skin2() {
    return SCHomeSkin2();
  }
}