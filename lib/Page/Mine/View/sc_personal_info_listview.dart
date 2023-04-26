import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/Mine/GetXController/sc_personal_info_controller.dart';
import 'package:smartcommunity/Page/Mine/Model/sc_upload_headpic_model.dart';
import 'package:smartcommunity/Page/Mine/View/Setting/sc_setting_cell.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/Utils/Permission/sc_permission_utils.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import 'package:smartcommunity/Utils/Upload/sc_upload_utils.dart';
import 'package:smartcommunity/Utils/WeChat/sc_wechat_utils.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import '../../../Constants/sc_asset.dart';
import '../../../Constants/sc_default_value.dart';
import '../../../Utils/AliPay/sc_alipay_utils.dart';
import '../../../Utils/Date/sc_date_utils.dart';
import '../../../Constants/sc_type_define.dart';
import '../../../Utils/Router/sc_router_path.dart';

/// 个人资料listview

class SCPersonalInfoListView extends StatelessWidget {
  const SCPersonalInfoListView(
      {Key? key,
      this.userHeadPicUrl = SCAsset.iconMineUserDefault,
      this.genderString,
      this.birthdayString,
      this.userNameString})
      : super(key: key);

  /// 用户头像
  final String? userHeadPicUrl;

  /// 性别
  final String? genderString;

  /// 出生日期
  final String? birthdayString;

  /// 用户名
  final String? userNameString;

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  /// body
  Widget body(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return getCell(index, context);
        },
        separatorBuilder: (BuildContext context, int index) {
          bool isLine = true;
          if (index == 0) {
            isLine = false;
          }
          return getLine(isLine);
        },
        itemCount: 6);
  }

  /// cell
  Widget getCell(int index, BuildContext context) {

    if (index == 0) {
      return headPicItem();
    } else if (index == 1) {
      return SCSettingCell(
        title: '昵称',
        content: SCScaffoldManager.instance.user.nickName,
        cellType: SCSettingCellType.contentArrowType,
        onTap: () {
          SCRouterHelper.pathPage(SCRouterPath.nicknamePath, null);
        },
      );

    } else if (index == 2) {
      return SCSettingCell(
        title: '姓名',
        content: userNameString,
        tagType: SCTypeDefine.realNameVerifyStatusNo,
        cellType: SCSettingCellType.tagContentArrowType,
        onTap: () {
          //SCRouterHelper.pathPage(SCRouterPath.realNameVerifyPath, null);
        },
      );
    } else if (index == 3) {
      return SCSettingCell(
        title: '民族',
        content: '汉族',
        cellType: SCSettingCellType.contentArrowType,
        onTap: () {
          SCRouterHelper.pathPage(SCRouterPath.realNameVerifyPath, null);
        },
      );
    } else if (index == 4) {
      return SCSettingCell(
        title: '出生日期',
        content: birthdayString ?? '请选择',
        cellType: SCSettingCellType.contentArrowType,
        onTap: () {
          selectBirthdayAction(context);
        },
      );
    } else if (index == 5) {
      return SCSettingCell(
        title: '性别',
        content: genderString,
        cellType: SCSettingCellType.contentArrowType,
        onTap: () {
          selectSexAction(['男', '女'], context);
        },
      );
    } else if (index == 6) {
      return SCSettingCell(
        title: '支付宝支付',
        onTap: () {
          SCAliPayUtils.aliPay();
        },
      );
    } else if (index == 7) {
      return SCSettingCell(
        title: '微信支付',
        onTap: () {
          SCWeChatUtils.wechatPay(
            partnerId: 'partnerId',
            prepayId: 'prepayId',
            packageValue: 'packageValue',
            nonceStr: 'nonceStr',
            sign: 'sign',
            result: (result) {

            }
          );
        },
      );
    } else if (index == 8) {
      return SCSettingCell(
        title: '微信分享',
        onTap: () {
          SCWeChatUtils.shareWeb(url: 'https://www.baidu.com');
        },
      );
    } else {
      return const SizedBox(
        height: 100.0,
      );
    }
  }

  Widget getLine(bool isLine) {
    if (isLine) {
      return line();
    } else {
      return line10();
    }
  }

  /// line
  Widget line() {
    return Container(
      color: SCColors.color_FFFFFF,
      padding: const EdgeInsets.only(left: 16.0),
      child: Container(
        height: 0.5,
        width: double.infinity,
        color: SCColors.color_EDEDF0,
      ),
    );
  }

  Widget line10() {
    return Container(
      height: 8.0,
      width: double.infinity,
      color: SCColors.color_F5F5F5,
    );
  }

  /// 头像
  Widget headPicItem() {
    String userPicUrl = userHeadPicUrl ?? SCAsset.iconMineUserDefault;
    return GestureDetector(
      onTap: () {
        selectHeadPicAction();
      },
      child: Container(
        width: double.infinity,
        height: 130,
        color: SCColors.color_FFFFFF,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: SCUtils.imageWidget(url: userPicUrl, width: 60.0, height: 60.0, fit: BoxFit.cover),
            ),
            const SizedBox(height: 8,),
            const Text(
              '点击更换头像',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: SCFonts.f14,
                  fontWeight: FontWeight.w400,
                  color: SCColors.color_1B1D33
              ),)
          ],
        ),
      ),
    );
  }

  /// 选择头像
  selectHeadPicAction() {
    SCPermissionUtils.showImagePicker(requestType: RequestType.image, completionHandler: (result) {
      List<String> imagePathList = result;
      String imagePath = imagePathList.first;
      if (imagePath != '' && imagePath.isNotEmpty) {
        SCLoadingUtils.show(text: SCDefaultValue.loadingMessage);
        SCUploadUtils.uploadHeadPic(
            imagePath: imagePath,
            successHandler: (value) {
              SCLoadingUtils.hide();
              SCUploadHeadPicModel model = SCUploadHeadPicModel.fromJson(value);
              changeUserHeadPic(model);
            },
            failureHandler: (value) {
              SCLoadingUtils.failure(text: value['message']);
            });
      }
    });
  }

  /// 选择性别
  selectSexAction(List list, BuildContext context) {
    List<SCBottomSheetModel> dataList = [];
    for (int i = 0; i < list.length; i++) {
      SCBottomSheetModel scBottomSheetModel = SCBottomSheetModel(
          title: list[i],
          color: SCColors.color_1B1C33,
          fontSize: SCFonts.f16,
          fontWeight: FontWeight.w400);
      dataList.add(scBottomSheetModel);
    }
    SCDialogUtils.instance.showBottomDialog(
        context: context,
        dataList: dataList,
        onTap: (index, context) {
          int gender = SCUtils.getGenderNumber(genderString: list[index]);
          changeGender(gender: gender);
        });
  }

  /// 选择出生日期
  selectBirthdayAction(BuildContext context) {
    SCPickerUtils pickerUtils = SCPickerUtils(pickerType: SCPickerType.date);
    pickerUtils.completionHandler = (selectedValues, selecteds) {
      String dateString = SCDateUtils.transformDate(
          dateTime: selectedValues.first,
          formats: ['yyyy', '-', 'mm', '-', 'dd']);
      changeBirthday(birthday: dateString);
    };
    pickerUtils.showDatePicker(context: context ,dateType: PickerDateTimeType.kYMD, columnFlex: [1, 1, 1]);
  }

  /// 修改用户头像
  changeUserHeadPic(SCUploadHeadPicModel model) {
    var params = {
      "id": SCScaffoldManager.instance.user.id,
      "headPicUri": {
        "fileKey": model.fileKey,
        "name": model.name,
        "size": model.size,
        "suffix": model.suffix,
        "type": model.type
      },
    };
    SCPersonalInfoController state = Get.find<SCPersonalInfoController>();
    state.changeUserInfo(params: params);
  }

  /// 修改性别
  changeGender({required int gender}) {
    var params = {
      "id": SCScaffoldManager.instance.user.id,
      "gender": gender,
    };
    SCPersonalInfoController state = Get.find<SCPersonalInfoController>();
    state.changeUserInfo(params: params);
  }

  /// 修改出生日期
  changeBirthday({required String birthday}) {
    var params = {
      "id": SCScaffoldManager.instance.user.id,
      "birthday": birthday,
    };
    SCPersonalInfoController state = Get.find<SCPersonalInfoController>();
    state.changeUserInfo(params: params);
  }
}
