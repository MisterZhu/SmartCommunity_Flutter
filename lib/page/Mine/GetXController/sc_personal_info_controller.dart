import 'package:get/get.dart';

import '../../../constants/sc_asset.dart';

/// 个人资料controller

class SCPersonalInfoController extends GetxController {
  String userHeadPicUrl = SCAsset.iconMineUserDefault;
  
  /// 修改用户头像
  changeUserHeadPic({required String url}) {
    userHeadPicUrl = url;
    update();
  }
}