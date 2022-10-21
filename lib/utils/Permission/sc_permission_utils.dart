import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smartcommunity/constants/sc_default_value.dart';
import 'package:smartcommunity/constants/sc_key.dart';
import 'package:smartcommunity/sc_app.dart';
import 'package:smartcommunity/utils/sc_sp_utils.dart';
import 'package:smartcommunity/utils/sc_utils.dart';
import 'package:smartcommunity/widgets/Dialog/sc_base_dialog.dart';
import 'package:smartcommunity/widgets/Dialog/sc_dialog_utils.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../../constants/sc_colors.dart';
import '../../constants/sc_fonts.dart';
import '../../widgets/Dialog/sc_bottom_sheet_model.dart';
import '../Router/sc_router_helper.dart';
import '../Router/sc_router_path.dart';

/// 权限管理工具

class SCPermissionUtils {
  /// 使用扫一扫
  static scanCode({Function? completionHandler}) async {
    Future.delayed(const Duration(seconds: 0), () async {
      SCUtils.getCurrentContext(completionHandler: (context) async {
        bool isShowAlert = SCSpUtil.getBool(SCKey.kIsShowScanCodeAlert);
        if (!isShowAlert) {
          SCDialogUtils.instance.showMiddleDialog(
            context: context,
            title: "温馨提示",
            content: SCDefaultValue.scanAlertMessage,
            customWidgetButtons: [
              defaultCustomButton(context,
                  text: '取消',
                  textColor: SCColors.color_1B1C33,
                  fontWeight: FontWeight.w400),
              defaultCustomButton(context,
                  text: '确定',
                  textColor: SCColors.color_1B1C33,
                  fontWeight: FontWeight.w400, onTap: () async {
                SCSpUtil.setBool(SCKey.kIsShowScanCodeAlert, true);
                PermissionStatus permissionStatus =
                    await Permission.camera.request();
                if (permissionStatus == PermissionStatus.granted) {
                  var result = await SCRouterHelper.pathPage(
                      SCRouterPath.scanPath, null);
                  completionHandler?.call(result);
                } else {
                  noPermissionAlert(SCDefaultValue.noCameraPermissionMessage);
                }
              }),
            ],
          );
        } else {
          var result =
              await SCRouterHelper.pathPage(SCRouterPath.scanPath, null);
          completionHandler?.call(result);
        }
      });
    });
  }

  /// 使用相机相册
  static showImagePicker(
      {Function? completionHandler,
      int? maxLength,
      List<AssetEntity>? assets,
      RequestType? requestType}) {
    List<SCBottomSheetModel> dataList = [
      SCBottomSheetModel(
          title: "拍照",
          color: SCColors.color_1B1C33,
          fontSize: SCFonts.f16,
          fontWeight: FontWeight.w400),
      SCBottomSheetModel(
          title: '从相册选择',
          color: SCColors.color_1B1C33,
          fontSize: SCFonts.f16,
          fontWeight: FontWeight.w400)
    ];
    SCUtils.getCurrentContext(completionHandler: (context) async {
      SCDialogUtils.instance.showBottomDialog(
          context: context,
          dataList: dataList,
          onTap: (index, context) {
            if (index == 0) {
              // 相机
              takePhoto(completionHandler);
            } else {
              // 相册
              photoPicker(
                  completionHandler: completionHandler,
                  maxLength: maxLength,
                  assets: assets,
                  requestType: requestType);
            }
          });
    });
  }

  /// 相册选择照片
  static photoPicker(
      {Function? completionHandler,
      int? maxLength,
      List<AssetEntity>? assets,
      RequestType? requestType}) async {
    // 默认1张
    int maxCount = maxLength ?? 1;
    if (maxCount <= 0) {
      maxCount = 1;
    }
    SCUtils.getCurrentContext(completionHandler: (context) async {
      bool isShowAlert = SCSpUtil.getBool(SCKey.kIsShowPhotoAlert);
      if (!isShowAlert) {
        SCDialogUtils.instance.showMiddleDialog(
          context: context,
          title: "温馨提示",
          content: SCDefaultValue.photoAlertMessage,
          customWidgetButtons: [
            defaultCustomButton(context,
                text: '取消',
                textColor: SCColors.color_1B1C33,
                fontWeight: FontWeight.w400),
            defaultCustomButton(context,
                text: '确定',
                textColor: SCColors.color_1B1C33,
                fontWeight: FontWeight.w400, onTap: () async {
              SCSpUtil.setBool(SCKey.kIsShowPhotoAlert, true);
              PermissionStatus permissionStatus =
                  await Permission.photos.request();
              if (permissionStatus == PermissionStatus.granted) {
                SCUtils.getCurrentContext(completionHandler: (context) async {
                  List<AssetEntity>? result =
                      await AssetPicker.pickAssets(
                    context,
                    pickerConfig: AssetPickerConfig(
                        maxAssets: maxCount,
                        selectedAssets: assets,
                        requestType: requestType ?? RequestType.common,
                        textDelegate: const AssetPickerTextDelegate()),
                  );
                  if (result != null) {
                    List<String> imagesPathList = [];
                    //遍历
                    for(var entity in result){
                      File? imgFile = await entity.file;
                      if(imgFile != null) imagesPathList.add(imgFile.path);
                    }
                    completionHandler?.call(imagesPathList);
                  }
                });
              } else {
                noPermissionAlert(SCDefaultValue.noPhotoPermissionMessage);
              }
            }),
          ],
        );
      } else {
        PermissionStatus permissionStatus = await Permission.photos.request();
        if (permissionStatus == PermissionStatus.granted) {
          SCUtils.getCurrentContext(completionHandler: (context) async {
            List<AssetEntity>? result = await AssetPicker.pickAssets(
              context,
              pickerConfig: AssetPickerConfig(
                  maxAssets: maxCount,
                  selectedAssets: assets,
                  requestType: requestType ?? RequestType.common,
                  textDelegate: const AssetPickerTextDelegate()),
            );
            if (result != null) {
              List<String> imagesPathList = [];
              //遍历
              for(var entity in result){
                File? imgFile = await entity.file;
                if(imgFile != null) imagesPathList.add(imgFile.path);
              }
              completionHandler?.call(imagesPathList);
            }
          });
        } else {
          noPermissionAlert(SCDefaultValue.noPhotoPermissionMessage);
        }
      }
    });
  }

  /// 拍照
  static takePhoto(Function? completionHandler) {
    SCUtils.getCurrentContext(completionHandler: (context) async {
      bool isShowAlert = SCSpUtil.getBool(SCKey.kIsShowCameraAlert);
      if (!isShowAlert) {
        SCDialogUtils.instance.showMiddleDialog(
          context: context,
          title: "温馨提示",
          content: SCDefaultValue.cameraAlertMessage,
          customWidgetButtons: [
            defaultCustomButton(context,
                text: '取消',
                textColor: SCColors.color_1B1C33,
                fontWeight: FontWeight.w400),
            defaultCustomButton(context,
                text: '确定',
                textColor: SCColors.color_1B1C33,
                fontWeight: FontWeight.w400, onTap: () async {
              SCSpUtil.setBool(SCKey.kIsShowCameraAlert, true);
              PermissionStatus permissionStatus =
                  await Permission.camera.request();
              if (permissionStatus == PermissionStatus.granted) {
                ImagePicker picker = ImagePicker();
                final XFile? imageFile =
                    await picker.pickImage(source: ImageSource.camera);
                completionHandler?.call(imageFile!.path);
              } else {
                noPermissionAlert(SCDefaultValue.noCameraPermissionMessage);
              }
            }),
          ],
        );
      } else {
        PermissionStatus permissionStatus = await Permission.camera.request();
        if (permissionStatus == PermissionStatus.granted) {
          ImagePicker picker = ImagePicker();
          final XFile? imageFile =
              await picker.pickImage(source: ImageSource.camera);
          completionHandler?.call(imageFile!.path);
        } else {
          noPermissionAlert(SCDefaultValue.noCameraPermissionMessage);
        }
      }
    });
  }

  /// 无权限弹窗
  static noPermissionAlert(String message) {
    SCUtils.getCurrentContext(completionHandler: (context) async {
      SCDialogUtils.instance.showMiddleDialog(
          title: "温馨提示",
          content: message,
          context: context,
          customWidgetButtons: [
            defaultCustomButton(context,
                text: '确定',
                textColor: SCColors.color_1B1C33,
                fontWeight: FontWeight.w400, onTap: () {
              openAppSettings();
            })
          ]);
    });
  }
}
