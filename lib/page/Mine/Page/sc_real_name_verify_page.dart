
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../constants/sc_colors.dart';
import '../../../constants/sc_fonts.dart';
import '../../../skin/View/sc_custom_scaffold.dart';
import '../../../utils/sc_utils.dart';
import '../GetXController/sc_real_name_verify_controller.dart';
import '../View/RealNameVerify/sc_real_name_verify_listview.dart';

/// 实名认证page

class SCRealNameVerifyPage extends StatefulWidget {
  @override
  SCRealNameVerifyPageState createState() => SCRealNameVerifyPageState();
}

class SCRealNameVerifyPageState extends State<SCRealNameVerifyPage> {

  SCRealNameVerifyController state = Get.put(SCRealNameVerifyController());

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
      resizeToAvoidBottomInset: false,
      title: "实名认证",
        centerTitle: true,
        elevation: 0,
        body: body(),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,///页面不会随着键盘上移
      appBar: AppBar(
        centerTitle: true,
        title: titleItem(),
        backgroundColor: SCColors.color_FFFFFF,
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: body(),
    );
  }

  /// title
  Widget titleItem() {
    return const Text("实名认证", style: TextStyle(
        fontSize: SCFonts.f18,
        fontWeight: FontWeight.w500,
        color: SCColors.color_1B1C33
    ),);
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
        color: SCColors.color_F5F5F5,
        child: SCRealNameVerifyListView(),
    ));
  }
}