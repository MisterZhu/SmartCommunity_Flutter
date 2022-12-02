
import 'dart:developer';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../../../Constants/sc_enum.dart';

class SCSearchCityController extends GetxController {

  /// 是否显示取消按钮
  bool isShowCancel = false;

  /// 定位权限
  LocationPermission locationPermission = LocationPermission.unableToDetermine;

  /// 定位的城市
  late String locationCity;

  /// 定位城市的编码
  String cityCode = '';

  /// 定位城市的纬度
  double latitude = 0.0;

  /// 定位城市的经度
  double longitude = 0.0;

  /// 定位状态，默认失败
  SCLocationStatus locationStatus = SCLocationStatus.failure;

  String pageName = '';

  String tag = '';

  @override
  onInit() {
    super.onInit();
    getCurrentTag();
  }

  /// 是否显示取消按钮
  updateCancelButtonStatus({bool status = false}) {
    isShowCancel = status;
    update();
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

}