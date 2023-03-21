import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../View/sc_message_listview.dart';

/// 消息page

class SCMessagePage extends StatefulWidget {
  @override
  SCMessagePageState createState() => SCMessagePageState();
}

class SCMessagePageState extends State<SCMessagePage> {

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "消息",
        centerTitle: true,
        navBackgroundColor: SCColors.color_FFFFFF,
        elevation: 0,
        body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: SCMessageListView(),
    );
  }
}

