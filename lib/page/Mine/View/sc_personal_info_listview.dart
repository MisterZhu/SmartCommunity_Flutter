import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/page/Mine/GetXController/sc_personal_info_controller.dart';
import 'package:smartcommunity/page/Mine/Model/sc_upload_headpic_model.dart';
import 'package:smartcommunity/page/Mine/View/Setting/sc_setting_cell.dart';
import 'package:smartcommunity/skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/utils/Loading/sc_loading_utils.dart';
import 'package:smartcommunity/utils/Permission/sc_permission_utils.dart';
import 'package:smartcommunity/utils/Router/sc_router_helper.dart';
import 'package:smartcommunity/utils/Upload/sc_upload_utils.dart';
import 'package:smartcommunity/utils/sc_utils.dart';
import 'package:smartcommunity/widgets/Picker/sc_picker_utils.dart';
import '../../../constants/sc_asset.dart';
import '../../../constants/sc_default_value.dart';
import '../../../constants/sc_enum.dart';
import '../../../utils/Date/sc_date_utils.dart';
import '../../../constants/sc_type_define.dart';
import '../../../utils/Router/sc_router_path.dart';

/// 设置listview

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
          if (index == 5 || index == 6 || index == 7) {
            isLine = false;
          }
          return getLine(isLine);
        },
        itemCount: 9);
  }

  /// cell
  Widget getCell(int index, BuildContext context) {
    /// 头像
    String userPicUrl = userHeadPicUrl ?? SCAsset.iconMineUserDefault;

    if (index == 0) {
      return SCSettingCell(
        title: '头像',
        cellType: SCSettingCellType.imageArrowType,
        imageUrl: userPicUrl,
        onTap: () {
          selectHeadPicAction();
        },
      );
    } else if (index == 1) {
      return SCSettingCell(
        title: '姓名',
        content: userNameString,
        tagType: SCTypeDefine.realNameVerifyStatusNo,
        cellType: SCSettingCellType.tagContentArrowType,
        onTap: () {
          SCRouterHelper.pathPage(SCRouterPath.realNameVerifyPath, null);
        },
      );
    } else if (index == 2) {
      return SCSettingCell(
        title: '昵称',
        content: SCScaffoldManager.instance.user.nickName,
        cellType: SCSettingCellType.contentArrowType,
        onTap: () {},
      );
    } else if (index == 3) {
      String? phone = SCScaffoldManager.instance.user.mobileNum;
      String phoneText = phone?.replaceRange(3, 7, '****') ?? '';
      return SCSettingCell(
        title: '手机号',
        content: phoneText,
        cellType: SCSettingCellType.contentArrowType,
        onTap: () {},
      );
    } else if (index == 4) {
      return SCSettingCell(
        title: '性别',
        content: genderString,
        cellType: SCSettingCellType.contentArrowType,
        onTap: () {
          selectSexAction();
        },
      );
    } else if (index == 5) {
      return SCSettingCell(
        title: '出生日期',
        content: birthdayString ?? '请选择',
        cellType: SCSettingCellType.contentArrowType,
        onTap: () {
          selectBirthdayAction();
        },
      );
    } else if (index == 6) {
      return SCSettingCell(
        title: '个性标签',
        onTap: () {},
      );
    } else if (index == 7) {
      return SCSettingCell(
        title: '服务要求',
        onTap: () {},
      );
    } else if (index == 8) {
      return SCSettingCell(
        title: '登录密码',
        onTap: () {},
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
      padding: const EdgeInsets.only(left: 12.0),
      child: Container(
        height: 0.5,
        width: double.infinity,
        color: SCColors.color_EDEDF0,
      ),
    );
  }

  Widget line10() {
    return Container(
      height: 10.0,
      width: double.infinity,
      color: SCColors.color_F5F5F5,
    );
  }

  /// 选择头像
  selectHeadPicAction() {
    SCPermissionUtils.showImagePicker(completionHandler: (result) {
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
  selectSexAction() {
    SCPickerUtils pickerUtils =
        SCPickerUtils(pickerType: SCPickerType.normal, pickerData: ['男', '女']);
    pickerUtils.completionHandler = (selectedValues, selecteds) {
      String genderString = '男';
      int gender = 1;

      if (selectedValues.isNotEmpty) {
        genderString = selectedValues.first;
      }

      gender = SCUtils.getGenderNumber(genderString: genderString);
      changeGender(gender: gender);
    };
    pickerUtils.showPicker();
  }

  /// 选择出生日期
  selectBirthdayAction() {
    SCPickerUtils pickerUtils = SCPickerUtils(pickerType: SCPickerType.date);
    pickerUtils.completionHandler = (selectedValues, selecteds) {
      String dateString = SCDateUtils.transformDate(
          dateTime: selectedValues.first,
          formats: ['yyyy', '-', 'mm', '-', 'dd']);
      changeBirthday(birthday: dateString);
    };
    pickerUtils.showDatePicker(
        dateType: PickerDateTimeType.kYMD, columnFlex: [1, 1, 1]);
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
