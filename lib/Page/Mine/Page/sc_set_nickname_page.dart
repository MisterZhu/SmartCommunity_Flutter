
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../Skin/View/sc_custom_scaffold.dart';

/// 设置昵称page

class SCSetNicknamePage extends StatefulWidget {
  @override
  SCSetNicknamePageState createState() => SCSetNicknamePageState();
}

class SCSetNicknamePageState extends State<SCSetNicknamePage> {

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "设置昵称", centerTitle: true, elevation: 0, body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F5F5F5,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      child: Column(
        children: [
          SizedBox(height: 8.0,),
          const Text(
            '不超过10个字符',
            textAlign: TextAlign.left,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: SCFonts.f12,
                fontWeight: FontWeight.w400,
                color: SCColors.color_8D8E99
            ),),
        ],
      ),
    );
  }
}