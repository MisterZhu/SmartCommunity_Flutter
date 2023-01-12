/// 定位工具类
import 'dart:developer';
import 'package:geolocator/geolocator.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../Constants/sc_default_value.dart';
import '../Network/sc_http_manager.dart';
import '../Network/sc_url.dart';
import '../Page/Login/Model/SelectCommunity/sc_location_model.dart';

class SCLocationUtils {

  /// 获取位置-仅仅是posotion, status:0-权限被拒绝，1-获取成功，2-权限无法确定
  static locationOnlyPosition(Function(Position? position, int status)? completeHandler) async{
    LocationPermission permission = await SCLocationUtils.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      /// 定位被拒绝，无权限
      completeHandler?.call(null, 0);
    } else if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      /// 已获取定位权限
      Position position = await SCLocationUtils.location();
      completeHandler?.call(position, 1);
    } else {
      /// 权限无法确定
      completeHandler?.call(null, 2);
    }
  }

  /// 获取具体微信信息, status:0-权限被拒绝，1-获取成功，2-权限无法确定
  static locationAll(Function(dynamic? result, int status)? completeHandler) async{
    LocationPermission permission = await SCLocationUtils.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      /// 定位被拒绝，无权限
      completeHandler?.call(null, 0);
    } else if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      /// 已获取定位权限
      Position position = await SCLocationUtils.location();
      reGeoCode(position: position, success: (value){
        SCLocationModel model = value;
        var params = {
          "longitude" : position.longitude,
          "latitude" : position.latitude,
          "data" : model
        };
        completeHandler?.call(params, 1);
      }, failure: (value){
        completeHandler?.call(value, 1);
      });
    } else {
      /// 权限无法确定
      completeHandler?.call(null, 2);
    }
  }

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

    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kReGeoCodeUrl, params: params, success: (response) {
      int status = int.parse(response['status']);
      if (status == 1) {
        var data = response['regeocode'];
        SCLocationModel model = SCLocationModel.fromJson(data);

        success?.call(model);
      } else {
        failure?.call(SCDefaultValue.errorMessage);
      }
    }, failure: (error) {
      failure?.call(SCDefaultValue.errorMessage);
    });
  }
}