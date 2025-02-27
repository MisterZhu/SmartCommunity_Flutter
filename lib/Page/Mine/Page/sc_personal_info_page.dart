

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/Mine/GetXController/sc_personal_info_controller.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';
import '../../../Skin/View/sc_custom_scaffold.dart';
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
      child: GetBuilder<SCPersonalInfoController>(builder: (state){
        return SCPersonalInfoListView(
          userNameString: SCScaffoldManager.instance.user.userName,
          birthdayString: SCScaffoldManager.instance.user.birthday,
          userHeadPicUrl: SCScaffoldManager.instance.user.getHeadPicUrl(),
          genderString: SCUtils.getGenderString(gender: SCScaffoldManager.instance.user.gender ?? 0,
          ),
        );
      }),
    );
  }
}