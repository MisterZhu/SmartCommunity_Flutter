import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/constants/sc_fonts.dart';
import 'package:smartcommunity/utils/Router/sc_router_helper.dart';
import 'package:smartcommunity/widgets/Picker/sc_picker_header.dart';

import '../../utils/sc_utils.dart';

/// picker

class SCPickerUtils {
  late List pickerData;

  Function(List selectedValues, List selecteds)? completionHandler;

  late final Picker _picker;

  /// 普通picker
  showPicker() {
    SCUtils.getCurrentContext(completionHandler: (context) async {
      double itemExtent = 42.0;
      Color bgColor = Colors.white;
      Color txtColor = SCColors.color_5E5F66;
      TextStyle txtStyle = TextStyle(color: txtColor, fontSize: SCFonts.f16);
      Color selectColor = SCColors.color_1B1C33;
      TextStyle selectStyle =
          TextStyle(color: selectColor, fontSize: SCFonts.f18);
      TextStyle titleStyle =
          const TextStyle(fontSize: SCFonts.f12, color: SCColors.color_5E5F66);
      TextStyle cancelTextStyle =
          const TextStyle(fontSize: 16.0, color: SCColors.color_FF571A);
      TextStyle sureTextStyle =
          const TextStyle(fontSize: 16.0, color: SCColors.color_FF571A);
      final delimiterChild = Align(
        alignment: Alignment.center,
        child: Container(width: 0, height: itemExtent, color: selectColor),
      );
      Picker picker = Picker(
        height: 260.0,
        adapter: PickerDataAdapter<String>(pickerdata: pickerData),
        changeToFirst: false,
        textAlign: TextAlign.center,
        textStyle: const TextStyle(
            color: SCColors.color_B0B1B8, fontSize: SCFonts.f16),
        selectedTextStyle: const TextStyle(
            color: SCColors.color_1B1C33, fontSize: SCFonts.f18),
        columnPadding: const EdgeInsets.symmetric(horizontal: 8.0),
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
        delimiter: [
          PickerDelimiter(column: 0, child: delimiterChild),
          PickerDelimiter(column: 2, child: delimiterChild),
        ],
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
  showDatePicker() {
    SCUtils.getCurrentContext(completionHandler: (context) async {
      double itemExtent = 42.0;
      Picker picker = Picker(
        height: 260.0,
        adapter: DateTimePickerAdapter(
            type: PickerDateTimeType.kYMD, isNumberMonth: true),
        changeToFirst: false,
        textAlign: TextAlign.center,
        textStyle: const TextStyle(
            color: SCColors.color_B0B1B8, fontSize: SCFonts.f16),
        selectedTextStyle: const TextStyle(
            color: SCColors.color_1B1C33, fontSize: SCFonts.f18),
        columnPadding: const EdgeInsets.symmetric(horizontal: 8.0),
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
    completionHandler?.call(_picker.getSelectedValues(), _picker.selecteds);
  }

  /// 取消
  cancelAction() {
    SCRouterHelper.back(null);
  }
}
