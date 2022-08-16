import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/constants/sc_fonts.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_login_controller.dart';
import 'package:smartcommunity/page/Login/View/Login/sc_login_listview.dart';

import '../../../utils/sc_utils.dart';

/// 登录page
class SCLoginPage extends StatefulWidget {
  @override
  SCLoginState createState() => SCLoginState();
}

class SCLoginState extends State<SCLoginPage> {

  SCLoginController state = Get.put(SCLoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: titleItem(),
        backgroundColor: SCColors.color_F6F6F6,
        elevation: 0,
      ),
      body: body(),
    );
  }

  /// body
  Widget body() {
    return GestureDetector(
      onTap: (){
        SCUtils().hideKeyboard(context: context);
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: SCColors.color_F6F6F6,
        child: SCLoginListView(),
      ),
    );
  }

  /// title
  Widget titleItem() {
    return const Text('登录', style: TextStyle(
      fontSize: SCFonts.f16,
      fontWeight: FontWeight.bold,
      color: SCColors.color_1B1C33
    ),);
  }
}