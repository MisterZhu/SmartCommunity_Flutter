import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:smartcommunity/Constants/sc_colors.dart';
import 'package:smartcommunity/Constants/sc_enum.dart';
import 'package:smartcommunity/Constants/sc_fonts.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import 'package:smartcommunity/Widgets/Picker/sc_picker_header.dart';

import '../../Utils/sc_utils.dart';

/// picker

class SCPickerUtils {

  SCPickerUtils({
    this.pickerType,
    this.pickerData
});
  List? pickerData;

  Function(List selectedValues, List selecteds)? completionHandler;

  late Picker _picker;

  SCPickerType? pickerType;

  /// 普通picker
  showPicker() {
    SCUtils.getCurrentContext(completionHandler: (context) async {
      double itemExtent = 42.0;
      TextStyle textStyle = const TextStyle(
          color: SCColors.color_B0B1B8, fontSize: SCFonts.f16);
      TextStyle selectStyle = const TextStyle(
          color: SCColors.color_1B1C33, fontSize: SCFonts.f18);
      Picker picker = Picker(
        height: 260.0,
        adapter: PickerDataAdapter<String>(pickerdata: pickerData),
        changeToFirst: false,
        textAlign: TextAlign.center,
        textStyle: textStyle,
        selectedTextStyle: selectStyle,
        selectionOverlay: Container(
          height: itemExtent,
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Divider(
                color: SCColors.color_EDEDF0,
                height: 0.5,
              ),
              Divider(
                color: SCColors.color_EDEDF0,
                height: 0.5,
              ),
            ],
          ),
        ),
        builderHeader: (BuildContext context) {
          return SCPickerHeader(
            sureText: '确定',
            cancelText: '取消',
            sureTap: () {
              confirmAction();
            },
            cancelTap: () {
              cancelAction();
            },
          );
        },
      );
      picker.showModal(context);
      _picker = picker;
    });
  }

  /// 日历picker
  showDatePicker({required int dateType, List<int>? columnFlex}) {
    double itemExtent = 42.0;
    TextStyle textStyle = const TextStyle(
        color: SCColors.color_B0B1B8, fontSize: SCFonts.f16);
    TextStyle selectStyle = const TextStyle(
        color: SCColors.color_1B1C33, fontSize: SCFonts.f18);
    SCUtils.getCurrentContext(completionHandler: (context) async {
      Picker picker = Picker(
        height: 260.0,
        columnPadding: EdgeInsets.zero,
        columnFlex: columnFlex,
        adapter: DateTimePickerAdapter(
            type: dateType, isNumberMonth: true, yearSuffix: '年', monthSuffix: '月', daySuffix: '日'),
        changeToFirst: false,
        textAlign: TextAlign.center,
        textStyle: textStyle,
        selectedTextStyle: selectStyle,
        selectionOverlay: Container(
          height: itemExtent,
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Divider(
                color: SCColors.color_EDEDF0,
                height: 0.5,
              ),
              Divider(
                color: SCColors.color_EDEDF0,
                height: 0.5,
              ),
            ],
          ),
        ),
        builderHeader: (BuildContext context) {
          return SCPickerHeader(
            sureText: '确定',
            cancelText: '取消',
            sureTap: () {
              confirmAction();
            },
            cancelTap: () {
              cancelAction();
            },
          );
        },
      );
      picker.showModal(context);
      _picker = picker;
    });
  }

  /// 确定
  confirmAction() {
    SCRouterHelper.back(null);
    if(pickerType ==  SCPickerType.date) {
      completionHandler?.call([(_picker.adapter as DateTimePickerAdapter).value], _picker.selecteds);
    } else {
      completionHandler?.call(_picker.getSelectedValues(), _picker.selecteds);
    }
  }

  /// 取消
  cancelAction() {
    SCRouterHelper.back(null);
  }
}
