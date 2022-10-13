
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_login_controller.dart';
import 'package:smartcommunity/page/Login/View/Login/sc_login_listview.dart';
import '../../../utils/sc_utils.dart';

/// 登录page
class SCLoginPage extends StatefulWidget {

  const SCLoginPage({Key? key}) : super(key: key);

  @override
  SCLoginState createState() => SCLoginState();
}

class SCLoginState extends State<SCLoginPage> {

  SCLoginController state = Get.put(SCLoginController());

  late bool showCloseBtn = false;
  @override
  initState() {
    super.initState();
    var params = Get.arguments;
    if (params != null && params != '') {
      showCloseBtn = params['showClose'];
      state.updateShowCloseBtnState(show: showCloseBtn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,///页面不会随着键盘上移
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
        child: SCLoginListView(showClose: showCloseBtn),
      ),
    );
  }

}