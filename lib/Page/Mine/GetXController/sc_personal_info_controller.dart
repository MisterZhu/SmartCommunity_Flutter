import 'package:get/get.dart';
import 'package:smartcommunity/Constants/sc_default_value.dart';
import 'package:smartcommunity/Network/sc_http_manager.dart';
import 'package:smartcommunity/Network/sc_url.dart';
import 'package:smartcommunity/Page/Mine/GetXController/sc_mine_controller.dart';
import 'package:smartcommunity/Page/Mine/Model/sc_upload_headpic_model.dart';
import 'package:smartcommunity/Page/Mine/Model/sc_user_info_model.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/Utils/Loading/sc_loading_utils.dart';

import '../../../Constants/sc_asset.dart';
import '../../../Skin/Model/sc_user.dart';

/// 个人资料controller

class SCPersonalInfoController extends GetxController {
  String userHeadPicUrl = SCAsset.iconMineUserDefault;

  /// 修改用户信息
  changeUserInfo({required dynamic params}) {
    SCLoadingUtils.show(text: SCDefaultValue.loadingMessage);
    SCHttpManager.instance.put(
        url: SCUrl.kChangeAccountInfoUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          getUserInfo();
        },
        failure: (value) {
          SCLoadingUtils.show(text: value['message']);
        });
    update();
  }

  /// 获取用户信息
  getUserInfo({Function? successHandler, bool? updateAll}) {
    SCHttpManager.instance.get(
        url: SCUrl.kFetchUserInfoUrl,
        success: (value) {
          bool updateStatus = updateAll ?? true;
          SCUserInfoModel userInfoModel = SCUserInfoModel.fromJson(value);

          /// 存储数据到SCUser
          SCUser scUser = SCScaffoldManager.instance.getUserData();
          scUser.id = userInfoModel.id;
          scUser.account = userInfoModel.account;
          scUser.userName = userInfoModel.userName;
          scUser.nickName = userInfoModel.nickName;
          scUser.headPicUri = userInfoModel.headPicUri;
          scUser.gender = userInfoModel.gender;
          scUser.birthday = userInfoModel.birthday;
          SCScaffoldManager.instance.cacheUserData(scUser.toJson());
          /// 更新
          update();
          if (updateStatus) {
            SCMineController mineController = Get.find<SCMineController>();
            mineController.update();
          }
          successHandler?.call();
        },
        failure: (value) {});
  }
}
