import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_default_value.dart';
import 'package:smartcommunity/Network/sc_http_manager.dart';
import 'package:smartcommunity/Network/sc_url.dart';
import 'package:smartcommunity/Page/Mine/GetXController/sc_mine_controller.dart';
import 'package:smartcommunity/Page/Mine/Model/sc_user_info_model.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import '../../../Constants/sc_asset.dart';
import '../../../Skin/Model/sc_user.dart';
import '../Model/sc_house_list_model.dart';

/// 个人资料controller

class SCPersonalInfoController extends GetxController {
  String userHeadPicUrl = SCAsset.iconMineUserDefault;

  /// 修改用户信息
  changeUserInfo({required dynamic params, Function? successHandler}) {
    SCLoadingUtils.show(text: SCDefaultValue.loadingMessage);
    SCHttpManager.instance.put(
        url: SCUrl.kChangeAccountInfoUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          getUserInfo(successHandler: () {
            successHandler?.call();
          });
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
          var communityId = SCScaffoldManager.instance.user.communityId ?? "";
          var spaceId = SCScaffoldManager.instance.user.spaceId ?? 0;

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
          if (communityId.isNotEmpty) {
            scUser.communityId = communityId;
            scUser.spaceId = spaceId;
          }
          SCScaffoldManager.instance.cacheUserData(scUser.toJson());

          if (updateStatus) {
            SCMineController mineController = Get.find<SCMineController>();
            mineController.update();
          }
          if (communityId.isEmpty) {
            getCommunityId(success: () {
              successHandler?.call();
            });
          }else{
            successHandler?.call();
          }

          update();
        },
        failure: (value) {});
  }

  /// 获取房号列表，取第一个审核通过的房号为默认房号
  getCommunityId({Function? success}) {
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kMyHouseUrl,
        success: (value) {
          List list = List<SCHouseListModel>.from(value.map((e) => SCHouseListModel.fromJson(e)).toList());
          for (int i = 0; i < list.length; i++ ) {
            SCHouseListModel model = list[i];
            if (model.examineStatus == 1) {//examineStatus审核状态, 0 审核中, 1 审核通过, 2 审核拒绝
              /// 存储communityId数据到SCUser
              SCUser scUser = SCScaffoldManager.instance.getUserData();
              scUser.communityId = model.communityId;
              print("------------------4444444444${scUser.communityId}");

              scUser.spaceId = model.spaceId;
              SCScaffoldManager.instance.cacheUserData(scUser.toJson());
            }
          }
          success?.call();
        },
        failure: (value) {

        });
  }
}
