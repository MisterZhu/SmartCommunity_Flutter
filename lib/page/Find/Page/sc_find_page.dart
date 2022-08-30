import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/page/Home/GetXController/sc_home_controller.dart';

import '../../Home/View/Skin2/sc_home_skin2.dart';


/// 发现-page

class SCFindPage extends StatefulWidget {
  const SCFindPage({Key? key}) : super(key: key);

  @override
  SCFindState createState() => SCFindState();
}

class SCFindState extends State<SCFindPage> with AutomaticKeepAliveClientMixin {
  //SCHomeController state = Get.put(SCHomeController());

  @override
  Widget build(BuildContext context) {
    return body();
  }

  @override
  bool get wantKeepAlive => true;

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
        child: skin1(),
      ),
    );
  }

  /// skin1
  Widget skin1() {
    return const SCHomeSkin2();
  }
}
