
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/Login/GetXController/sc_login_controller.dart';
import 'package:smartcommunity/Page/Login/View/Login/sc_login_listview.dart';
import '../../../Utils/sc_utils.dart';

/// 登录page
class SCLoginPage extends StatefulWidget {

  late bool showCloseBtn;

  SCLoginPage({Key? key, this.showCloseBtn = false}) : super(key: key);

  @override
  SCLoginState createState() => SCLoginState();
}

class SCLoginState extends State<SCLoginPage> {

  SCLoginController state = Get.put(SCLoginController());

  @override
  initState() {
    super.initState();
    var params = Get.arguments;
    if (params != null && params != '') {
      widget.showCloseBtn = params['showClose'];
    }
    state.showCloseBtn = widget.showCloseBtn;
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
        child: SCLoginListView(state: state, showClose: widget.showCloseBtn),
      ),
    );
  }

}