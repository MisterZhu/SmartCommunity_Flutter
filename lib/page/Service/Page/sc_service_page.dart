import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/page/Service/GetXController/sc_service_controller.dart';

import '../../../constants/sc_colors.dart';
import '../../../constants/sc_fonts.dart';
import '../View/sc_service_listView.dart';

/// 服务-page

class SCServicePage extends StatefulWidget {
  @override
  SCServiceState createState() => SCServiceState();
}



class SCServiceState extends State<SCServicePage> {
  SCServiceController state = Get.put(SCServiceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: titleItem(),
        backgroundColor: SCColors.color_FFFFFF,
        elevation: 0,
      ),
      body: body(),
    );
  }

  /// body
  Widget body() {
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: SCColors.color_F6F6F6,
        child: SCServiceListView(),
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


}