
import 'package:flutter/cupertino.dart';
import '../../../constants/sc_colors.dart';
import '../../../skin/View/sc_custom_scaffold.dart';
import '../View/RealNameVerify/sc_real_name_verify_listview.dart';

/// 实名认证page

class SCRealNameVerifyPage extends StatefulWidget {
  @override
  SCRealNameVerifyPageState createState() => SCRealNameVerifyPageState();
}

class SCRealNameVerifyPageState extends State<SCRealNameVerifyPage> {

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "实名认证", centerTitle: true, elevation: 0, body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F5F5F5,
      child: SCRealNameVerifyListView(),
    );
  }
}