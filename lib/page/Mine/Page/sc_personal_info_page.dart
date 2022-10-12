

import 'package:flutter/cupertino.dart';

import '../../../constants/sc_colors.dart';
import '../../../skin/View/sc_custom_scaffold.dart';
import '../View/sc_personal_info_listview.dart';

/// 个人资料page

class SCPersonalInfoPage extends StatefulWidget {
  @override
  SCPersonalInfoPageState createState() => SCPersonalInfoPageState();
}

class SCPersonalInfoPageState extends State<SCPersonalInfoPage> {

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "个人资料", centerTitle: true, elevation: 0, body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F5F5F5,
      child: SCPersonalInfoListView(),
    );
  }
}