
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../Utils/Date/sc_date_utils.dart';
import '../../../Utils/sc_utils.dart';
import '../GetXController/sc_improve_data_controller.dart';
import '../GetXController/sc_login_controller.dart';
import '../View/ImproveData/sc_improve_data_alert.dart';
import '../View/ImproveData/sc_input_name_alert.dart';

/// 完善资料page

class SCImproveDataPage extends StatefulWidget {
  SCImproveDataPage({Key? key, this.phone, this.code}) : super(key: key);

  /// 手机号
  final String? phone;

  /// 验证码
  final String? code;

  @override
  SCImproveDataPageState createState() => SCImproveDataPageState();
}

class SCImproveDataPageState extends State<SCImproveDataPage> {

  SCImproveDataController state = Get.put(SCImproveDataController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// body
  Widget body() {
    return Stack(
      children: [
        maskItem(),
        improveDataAlertItem(),
        inputNameAlert(),
      ],
    );
  }

  /// 半透明背景蒙层
  Widget maskItem() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_000000.withOpacity(0.5),
    );
  }

  /// 完善信息弹窗
  Widget improveDataAlertItem() {
    return GetBuilder<SCImproveDataController>(builder: (state) {
      return SCImproveDataAlert(
        list: [
          {'required': true, 'name': '姓名', 'content': state.name ?? '请输入'},
          {'required': false, 'name': '出生日期', 'content': state.birthday ?? '请选择'},
          {'required': false, 'name': '性别', 'content': state.gender ?? '请选择'}],
        nameAction: () {
          state.updateInputNameAlertStatus();
        },
        birthdayAction: () {
          selectBirthdayAction(context);
        },
        genderAction: () {
          selectSexAction(['男', '女']);
        },
        sureAction: () {
          if (state.name != null) {
            SCLoginController loginState = Get.find<SCLoginController>();
            int gender = SCUtils.getGenderNumber(genderString: state.gender ?? '男');
            loginState.codeLoginWithName(
              userInputName: state.name!,
              birthday: state.birthday ?? '',
              gender: '$gender',
              resultHandler: (){
              state.name = null;
              state.birthday = null;
              state.gender = null;
            });
          } else {
            SCToast.showTip('姓名不能为空');
          }
        },
      );
    });
  }

  /// 输入姓名弹窗
  Widget inputNameAlert() {
    return GetBuilder<SCImproveDataController>(builder: (state) {
      return Offstage(
        offstage: !state.showInputNameAlert,
        child: SCInputNameAlert(
          sureAction: (name) {
            state.updateName(name);
            state.updateInputNameAlertStatus();
          }
        ),
      );
    });
  }

  /// 选择性别
  selectSexAction(List list) {
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
         state.updateGender(list[index]);
      });
  }

  /// 选择出生日期
  selectBirthdayAction(BuildContext context) {
    SCPickerUtils pickerUtils = SCPickerUtils(pickerType: SCPickerType.date);
    pickerUtils.completionHandler = (selectedValues, selecteds) {
      String dateString = SCDateUtils.transformDate(
          dateTime: selectedValues.first,
          formats: ['yyyy', '-', 'mm', '-', 'dd']);
      state.updateBirthday(dateString);
    };
    pickerUtils.showDatePicker(context: context ,dateType: PickerDateTimeType.kYMD, columnFlex: [1, 1, 1]);
  }

}
