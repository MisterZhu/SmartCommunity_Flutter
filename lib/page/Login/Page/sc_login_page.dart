
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/constants/sc_fonts.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_login_controller.dart';
import 'package:smartcommunity/page/Login/View/Login/sc_login_listview.dart';

import '../../../constants/sc_agreement.dart';
import '../../../utils/Router/sc_router_helper.dart';
import '../../../utils/sc_utils.dart';
import '../View/Login/sc_login_agreement.dart';

/// 登录page
class SCLoginPage extends StatefulWidget {

  const SCLoginPage({Key? key}) : super(key: key);

  @override
  SCLoginState createState() => SCLoginState();
}

class SCLoginState extends State<SCLoginPage> {

  SCLoginController state = Get.put(SCLoginController());

  late bool showCloseBtn = true;
  @override
  initState() {
    super.initState();

    var params = Get.arguments;
    if (params != null) {
      showCloseBtn = params['showClose'];
      print('showCloseBtn=====$showCloseBtn');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        color: SCColors.color_F2F3F5,
        child: SCLoginListView(showClose: showCloseBtn,),
      ),
    );
  }

}