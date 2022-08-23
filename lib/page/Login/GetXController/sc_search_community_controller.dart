

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../constants/sc_enum.dart';

class SCSearchCommunityController extends GetxController {

  /// 是否显示取消按钮
  bool isShowCancel = false;

  /// 输入框node
  FocusNode node = FocusNode();

  /// 定位权限
  LocationPermission locationPermission = LocationPermission.unableToDetermine;

  /// 定位的城市
  String locationCity = '';

  /// 定位城市的编码
  String cityCode = '';

  /// 定位城市的纬度
  double latitude = 0.0;

  /// 定位城市的经度
  double longitude = 0.0;

  /// 定位状态，默认失败
  SCLocationStatus locationStatus = SCLocationStatus.failure;

  /// 用户选择的城市
  String selectCity = '';

  /// 用户选择城市的编码
  String selectCityCode = '';

  @override
  onInit() {
    super.onInit();
  }

  /// 是否显示取消按钮
  updateCancelButtonStatus({bool status = false}) {
    isShowCancel = status;
    update();
  }

  /// 关闭键盘
  hideKeyboard() {
    node.unfocus();
  }

  /// 更新定位权限
  updateLocationPermission({required LocationPermission permission}) {
    locationPermission = permission;
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      /// 定位被拒绝，无权限
      locationStatus = SCLocationStatus.notOpen;
    } else if(permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      /// 已获取定位权限
      locationStatus = SCLocationStatus.success;
    } else {
      /// 权限无法确定
      locationStatus = SCLocationStatus.failure;
    }
    update();
  }

  /// 更新定位城市信息
  updateLocationCity({required String city, required String code, required double lati, required double long}) {
    locationCity = city;
    cityCode = code;
    latitude = lati;
    longitude = long;
    locationStatus = SCLocationStatus.success;
    update();
  }

  /// 更新选择的城市
  updateSelectCity({required String city, required String code}) {
    selectCity = city;
    selectCityCode = code;
    update();
  }

}