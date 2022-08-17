/// 定位工具类
import 'dart:developer';

import 'package:geolocator/geolocator.dart';

import '../constants/sc_default_value.dart';
import '../network/sc_http_manager.dart';
import '../network/sc_url.dart';
import '../page/Login/Model/SelectCommunity/sc_location_model.dart';

class SCLocationUtils {
  /// 获取定位权限
  static Future<LocationPermission> requestPermission() async{
    LocationPermission permission = await Geolocator.requestPermission();
    return permission;
  }

  /// 获取位置
  static Future<Position> location() async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  /// 打开定位设置
  static openLocationSetting() {
    GeolocatorPlatform platform = GeolocatorPlatform.instance;
    platform.openLocationSettings();
  }

  /// 逆地理编码
  static reGeoCode({required Position position, Function(dynamic value)? success, Function(dynamic value)? failure}) {
    var longitude = position.longitude;
    var latitude = position.latitude;
    var params = {
      'location': '$longitude,$latitude',
      'radius': '10',
      'extensions': 'base',
      'batch': false,
      'output': 'json',
      'key': SCDefaultValue.kAMapWebKey
    };
    SCHttpManager.instance.get(
        url: SCUrl.kReGeoCodeUrl, params: params, success: (response) {
      int status = int.parse(response['status']);
      if (status == 1) {
        log('位置成功:$response');
        var data = response['regeocode'];
        SCLocationModel model = SCLocationModel.fromJson(data);

        if (success != null) {
          success?.call(model);
        }
      } else {
        if (failure != null) {
          failure?.call(SCDefaultValue.errorMessage);
        }
      }
    }, failure: (error) {
      log('位置失败:$error');
      if (failure != null) {
        failure?.call(SCDefaultValue.errorMessage);
      }
    });
  }
}