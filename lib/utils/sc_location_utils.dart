/// 定位工具类
import 'package:geolocator/geolocator.dart';

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
}