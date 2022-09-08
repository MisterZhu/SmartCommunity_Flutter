import 'package:flutter/material.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/page/Mine/View/Setting/sc_setting_listview.dart';
import 'package:smartcommunity/skin/View/sc_custom_scaffold.dart';

/// 设置page

class SCSettingPage extends StatefulWidget {
  @override
  SCSettingState createState() => SCSettingState();
}

class SCSettingState extends State<SCSettingPage> {
  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(title: "设置", centerTitle: true, elevation: 0, body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_FFFFFF,
      child: SCSettingListView(),
    );
  }
}