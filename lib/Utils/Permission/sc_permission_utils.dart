import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smartcommunity/Constants/sc_default_value.dart';
import 'package:smartcommunity/Constants/sc_key.dart';
import 'package:smartcommunity/Page/Login/Model/SelectCommunity/sc_location_model.dart';
import 'package:smartcommunity/Utils/sc_location_utils.dart';
import 'package:smartcommunity/Utils/sc_sp_utils.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../Router/sc_router_helper.dart';
import '../Router/sc_router_path.dart';

/// 权限管理工具

class SCPermissionUtils {
  /// 使用扫一扫-隐私权限提示
  static scanCodeWithPrivacyAlert(
      {Function(dynamic result)? completionHandler}) async {
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
                    scanCode(completionHandler);
                  }),
            ],
          );
        } else {
          scanCode(completionHandler);
        }
      });
    });
  }

  /// 使用扫一扫-无隐私权限提示
  static scanCode(Function(dynamic result)? completionHandler) async {
    PermissionStatus permissionStatus = await Permission.camera.request();
    if (permissionStatus == PermissionStatus.granted) {
      var result = await SCRouterHelper.pathPage(SCRouterPath.scanPath, null);
      var params = {
        "status": 1, // 0-权限无法确定，1-成功，2-相机权限被拒绝
        "data": {"result": result}
      };
      completionHandler?.call(params);
    } else {
      var params = {
        "status": 2, // 0-权限无法确定，1-成功，2-相机权限被拒绝
        "data": {"result": ''}
      };
      completionHandler?.call(params);
      noPermissionAlert(SCDefaultValue.noCameraPermissionMessage);
    }
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
              takePhoto((String path){
                completionHandler?.call([path]);
              });
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
                        for (var entity in result) {
                          File? imgFile = await entity.file;
                          if (imgFile != null) imagesPathList.add(imgFile.path);
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
              for (var entity in result) {
                File? imgFile = await entity.file;
                if (imgFile != null) imagesPathList.add(imgFile.path);
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
  static takePhoto(Function(String path)? completionHandler) {
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

  /// 使用定位-隐私权限提示
  static startLocationWithPrivacyAlert(
      {Function(dynamic result, SCLocationModel? model)?
      completionHandler}) async {
    Future.delayed(const Duration(seconds: 0), () async {
      SCUtils.getCurrentContext(completionHandler: (context) async {
        bool isShowAlert = SCSpUtil.getBool(SCKey.kIsShowLocationAlert);
        if (!isShowAlert) {
          SCDialogUtils.instance.showMiddleDialog(
            context: context,
            title: "温馨提示",
            content: SCDefaultValue.locationAlertMessage,
            customWidgetButtons: [
              defaultCustomButton(context,
                  text: '取消',
                  textColor: SCColors.color_1B1C33,
                  fontWeight: FontWeight.w400),
              defaultCustomButton(context,
                  text: '确定',
                  textColor: SCColors.color_1B1C33,
                  fontWeight: FontWeight.w400, onTap: () async {
                    SCSpUtil.setBool(SCKey.kIsShowLocationAlert, true);
                    startLocation(completionHandler: completionHandler);
                  }),
            ],
          );
        } else {
          startLocation(completionHandler: completionHandler);
        }
      });
    });
  }

  /// 使用定位-无隐私权限提示
  static startLocation(
      {Function(dynamic result, SCLocationModel? model)?
      completionHandler}) async {
    LocationPermission permission = await SCLocationUtils.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      /// 定位被拒绝，无权限
      var params = {
        "status": 2, // 0-权限无法确定，1-成功，2-相机权限被拒绝
        "data": {"result": ''}
      };
      completionHandler?.call(params, null);
    } else if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      /// 已获取定位权限
      Position position = await SCLocationUtils.location();
      reGeoCode(position: position, completionHandler: completionHandler);
    } else {
      /// 权限无法确定
      var params = {
        "status": 0, // 0-权限无法确定，1-成功，2-相机权限被拒绝
        "data": {"result": ''}
      };
      completionHandler?.call(params, null);
    }
  }

  /// 逆地理编码
  static reGeoCode(
      {required Position position,
        Function(dynamic result, SCLocationModel? model)?
        completionHandler}) async {
    await SCLocationUtils.reGeoCode(
        position: position,
        success: (value) {
          SCLocationModel model = value;
          var params = {
            "status": 1,
            "data": {
              "longitude": position.longitude,
              "latitude": position.latitude,
              "city": model.addressComponent?.city,
              "cityCode": model.addressComponent?.citycode
            }
          };
          completionHandler?.call(params, model);
        },
        failure: (value) {
          var params = {
            "status": 1,
            "data": {
              "longitude": position.longitude,
              "latitude": position.latitude,
            }
          };
          completionHandler?.call(params, null);
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
