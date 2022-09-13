import 'package:flutter/material.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/constants/sc_fonts.dart';
import 'package:smartcommunity/widgets/Dialog/sc_base_dialog.dart';
import 'package:smartcommunity/widgets/Dialog/sc_bottom_sheet.dart';
import 'package:smartcommunity/widgets/Dialog/sc_bottom_sheet_model.dart';

/// 弹窗工具类
class SCDialogUtils {
  factory SCDialogUtils() => _instance;

  static SCDialogUtils get instance => _instance;

  static final SCDialogUtils _instance = SCDialogUtils._internal();

  SCDialogUtils._internal() {
    /// set deafult value
  }

  /*
  *  SCDialogUtils.instance.showMiddleDialog(context: context, title: '提示', content: '弹窗内容', customWidgetButtons:[
  *    defaultCustomButton(context,text: '取消',textColor: SCColors.color_1B1C33,fontWeight: FontWeight.w400),
  *    TextButton(
  *       onPressed: (){},
  *       child: Text('Custom Button', style: TextStyle(color:  Colors.pinkAccent))
  *     )
  *  ],);
  */
  /// 中间弹窗
  Future showMiddleDialog<T>(
      {required BuildContext context,
      Color bgColor = SCColors.color_FFFFFF,
      bool isShowCloseButton = false,
      bool isNeedCloseDiaLog = true,
      DiaLogLocation location = DiaLogLocation.middle,
      bool isSystemBottomDialog = false,
      Widget? customTitleWidget,
      String? title,
      Color titleColor = SCColors.color_000000,
      double titleFontSize = SCFonts.f18,
      FontWeight titleFontWeight = FontWeight.w400,
      TextAlign titleAlign = TextAlign.center,
      Widget? customContentWidget,
      String? content,
      Color contentColor = const Color(0xFF1B1C33),
      double contentFontSize = SCFonts.f14,
      double notTitleContentFontSize = SCFonts.f18,
      FontWeight contentFontWeight = FontWeight.w400,
      TextAlign contentAlign = TextAlign.center,
      List<Widget>? customWidgetButtons,
      List<String>? buttons,
      Color cancelButtonColor = colorWithHex9,
      Color otherButtonColor = colorWithQ,
      double cancelButtonFontSize = SCFonts.f16,
      double otherButtonFontSize = SCFonts.f16,
      FontWeight cancelButtonFontWeight = FontWeight.w400,
      FontWeight otherButtonFontWeight = FontWeight.w400,
      ButtonArrangeType arrangeType = ButtonArrangeType.row,
      Function(int index, BuildContext context)? onTap}) {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return SCBaseDialog(
              bgColor: bgColor,
              isShowCloseButton: isShowCloseButton,
              isNeedCloseDiaLog: isNeedCloseDiaLog,
              customTitleWidget: customTitleWidget,
              location: location,
              isSystemBottomDialog: isSystemBottomDialog,
              title: title,
              titleColor: titleColor,
              titleFontSize: titleFontSize,
              titleFontWeight: titleFontWeight,
              titleAlign: titleAlign,
              customContentWidget: customContentWidget,
              content: content,
              contentColor: contentColor,
              contentFontSize: contentFontSize,
              notTitleContentFontSize: notTitleContentFontSize,
              contentFontWeight: contentFontWeight,
              contentAlign: contentAlign,
              customWidgetButtons: customWidgetButtons,
              buttons: buttons,
              cancelButtonColor: cancelButtonColor,
              otherButtonColor: otherButtonColor,
              cancelButtonFontSize: cancelButtonFontSize,
              otherButtonFontSize: otherButtonFontSize,
              cancelButtonFontWeight: cancelButtonFontWeight,
              otherButtonFontWeight: otherButtonFontWeight,
              arrangeType: arrangeType,
              onTap: onTap);
        });
  }

  /*
  *  var dataList = [
  *   SCBottomSheetModel.fromJson({
  *      "title": "任务1",
  *     "color": SCColors.color_1B1C33,
  *      "fontSize": SCFonts.f16,
  *      "fontWeight": FontWeight.w400
  *   }),
  *   SCBottomSheetModel.fromJson({
  *      "title": "任务2",
  *      "color": SCColors.color_1B1C33,
  *      "fontSize": SCFonts.f16,
  *      "fontWeight": FontWeight.w400
  *   })
  *  ];
  *  SCDialogUtils.instance.showBottomDialog(context: context, dataList: dataList, isShowCancel: false);
  *
  */
  /// 底部弹窗
  showBottomDialog(
      {required BuildContext context,
      required List<SCBottomSheetModel> dataList,
      bool? isShowCancel,
      SCBottomSheetModel? cancelModel,
      bool? isCloseDialog,
      Function(int index, BuildContext context)? onTap,
      Function(BuildContext context)? onCancelTap}) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        elevation: 0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        builder: (BuildContext context) {
          return SCBottomSheet(
            dataList: dataList,
            isShowCancel: isShowCancel,
            customCancelModel: cancelModel,
            isCloseDialog: isCloseDialog,
            onTap: (int index, BuildContext context) {
              if (onTap != null) {
                onTap?.call(index, context);
              }
            },
            onCancelTap: (BuildContext context) {
              if (onCancelTap != null) {
                onCancelTap?.call(context);
              }
            },
          );
        });
  }
}
