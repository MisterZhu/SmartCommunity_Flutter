import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// 设备

class SCDeviceUtils {

  /// 获取设备信息
  static getDeviceInfo({required Function(Map<String, dynamic>) result}) async{
    var deviceInfoPlugin = DeviceInfoPlugin();
    var deviceInfo = await deviceInfoPlugin.deviceInfo;
    var allInfo = deviceInfo.data;

    if (Platform.isIOS) {
      var utsname = allInfo['utsname'];
      String iMachine = utsname['machine'];
      allInfo['machine'] = getIphoneModel(iMachine);
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
      AndroidBuildVersion androidBuildVersion = androidDeviceInfo.version;
      String release = androidBuildVersion.release;
      allInfo['systemVersion'] = release;
      allInfo['machine'] = allInfo['manufacturer'];
      allInfo['systemName'] = "Android";
    }

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    allInfo['appName'] = appName;
    allInfo['packageName'] = packageName;
    allInfo['version'] = version;
    allInfo['buildNumber'] = buildNumber;

    result.call(allInfo);
  }

  /// 获取iPhone设备型号
  static String getIphoneModel(String iMachine) {
    // iPhone
    if (iMachine == "iPhone1,1") return "iPhone 2G";
    if (iMachine == "iPhone1,2") return "iPhone 3G";
    if (iMachine == "iPhone2,1") return "iPhone 3GS";
    if (iMachine == "iPhone3,1") return "iPhone 4";
    if (iMachine == "iPhone3,2") return "iPhone 4";
    if (iMachine == "iPhone3,3") return "iPhone 4";
    if (iMachine == "iPhone4,1") return "iPhone 4S";
    if (iMachine == "iPhone5,1") return "iPhone 5";
    if (iMachine == "iPhone5,2") return "iPhone 5";
    if (iMachine == "iPhone5,3") return "iPhone 5c";
    if (iMachine == "iPhone5,4") return "iPhone 5c";
    if (iMachine == "iPhone6,1") return "iPhone 5s";
    if (iMachine == "iPhone6,2") return "iPhone 5s";
    if (iMachine == "iPhone7,1") return "iPhone 6 Plus";
    if (iMachine == "iPhone7,2") return "iPhone 6";
    if (iMachine == "iPhone8,1") return "iPhone 6s";
    if (iMachine == "iPhone8,2") return "iPhone 6s Plus";
    if (iMachine == "iPhone8,4") return "iPhone SE 1";
    if (iMachine == "iPhone9,1") return "iPhone 7";
    if (iMachine == "iPhone9,3") return "iPhone 7";
    if (iMachine == "iPhone9,2") return "iPhone 7 Plus";
    if (iMachine == "iPhone9,4") return "iPhone 7 Plus";
    if (iMachine == "iPhone10,1") return "iPhone 8";
    if (iMachine == "iPhone10,4") return "iPhone 8";
    if (iMachine == "iPhone10,2") return "iPhone 8 Plus";
    if (iMachine == "iPhone10,5") return "iPhone 8 Plus";
    if (iMachine == "iPhone10,3") return "iPhone X";
    if (iMachine == "iPhone10,6") return "iPhone X";
    if (iMachine == "iPhone11,2") return "iPhone XS";
    if (iMachine == "iPhone11,4") return "iPhone XS MAX";
    if (iMachine == "iPhone11,6") return "iPhone XS MAX";
    if (iMachine == "iPhone11,8") return "iPhone XR";
    if (iMachine == "iPhone12,1") return "iPhone 11";
    if (iMachine == "iPhone12,3") return "iPhone 11 Pro";
    if (iMachine == "iPhone12,5") return "iPhone 11 Pro Max";
    if (iMachine == "iPhone12,8") return "iPhone SE 2";
    if (iMachine == "iPhone13,1") return "iPhone 12 mini";
    if (iMachine == "iPhone13,2") return "iPhone 12";
    if (iMachine == "iPhone13,3") return "iPhone 12 Pro";
    if (iMachine == "iPhone13,4") return "iPhone 12 Pro Max";
    if (iMachine == "iPhone14,4") return "iPhone 13 mini";
    if (iMachine == "iPhone14,5") return "iPhone 13";
    if (iMachine == "iPhone14,2") return "iPhone 13 Pro";
    if (iMachine == "iPhone14,3") return "iPhone 13 Pro Max";
    if (iMachine == "iPhone14,6") return "iPhone SE 3";
    if (iMachine == "iPhone14,7") return "iPhone 14";
    if (iMachine == "iPhone14,8") return "iPhone 14 Plus";
    if (iMachine == "iPhone15,2") return "iPhone 14 Pro";
    if (iMachine == "iPhone15,3") return "iPhone 14 Pro Max";


    // iPod
    if (iMachine == "iPod1,1") return "iPod Touch 1";
    if (iMachine == "iPod2,1") return "iPod Touch 2";
    if (iMachine == "iPod3,1") return "iPod Touch 3";
    if (iMachine == "iPod4,1") return "iPod Touch 4";
    if (iMachine == "iPod5,1") return "iPod Touch 5";
    if (iMachine == "iPod7,1") return "iPod Touch 6";
    if (iMachine == "iPod9,1") return "iPod Touch 7";

    // iPad
    if (iMachine == "iPad1,1") return "iPad 1";
    if (iMachine == "iPad2,1") return "iPad 2";
    if (iMachine == "iPad2,2") return "iPad 2";
    if (iMachine == "iPad2,3") return "iPad 2";
    if (iMachine == "iPad2,4") return "iPad 2";
    if (iMachine == "iPad2,5") return "iPad Mini 1";
    if (iMachine == "iPad2,6") return "iPad Mini 1";
    if (iMachine == "iPad2,7") return "iPad Mini 1";
    if (iMachine == "iPad3,1") return "iPad 3";
    if (iMachine == "iPad3,2") return "iPad 3";
    if (iMachine == "iPad3,3") return "iPad 3";
    if (iMachine == "iPad3,4") return "iPad 4";
    if (iMachine == "iPad3,5") return "iPad 4";
    if (iMachine == "iPad3,6") return "iPad 4";
    if (iMachine == "iPad4,1") return "iPad Air";
    if (iMachine == "iPad4,2") return "iPad Air";
    if (iMachine == "iPad4,3") return "iPad Air";
    if (iMachine == "iPad4,4") return "iPad mini 2";
    if (iMachine == "iPad4,5") return "iPad mini 2";
    if (iMachine == "iPad4,6") return "iPad mini 2";
    if (iMachine == "iPad4,7") return "iPad mini 3";
    if (iMachine == "iPad4,8") return "iPad mini 3";
    if (iMachine == "iPad4,9") return "iPad mini 3";
    if (iMachine == "iPad5,1") return "iPad mini 4";
    if (iMachine == "iPad5,2") return "iPad mini 4";
    if (iMachine == "iPad5,3") return "iPad Air 2";
    if (iMachine == "iPad5,4") return "iPad Air 2";
    if (iMachine == "iPad6,3") return "iPad Pro (9.7-inch)";
    if (iMachine == "iPad6,4") return "iPad Pro (9.7-inch)";
    if (iMachine == "iPad6,7") return "iPad Pro (12.9-inch)";
    if (iMachine == "iPad6,8") return "iPad Pro (12.9-inch)";
    if (iMachine == "iPad6,11") return "iPad 5";
    if (iMachine == "iPad6,12") return "iPad 5";
    if (iMachine == "iPad7,1") return "iPad Pro 2(12.9-inch)";
    if (iMachine == "iPad7,2") return "iPad Pro 2(12.9-inch)";
    if (iMachine == "iPad7,3") return "iPad Pro (10.5-inch)";
    if (iMachine == "iPad7,4") return "iPad Pro (10.5-inch)";
    if (iMachine == "iPad7,5") return "iPad 6";
    if (iMachine == "iPad7,6") return "iPad 6";
    if (iMachine == "iPad7,11") return "iPad 7";
    if (iMachine == "iPad7,12") return "iPad 7";
    if (iMachine == "iPad8,1") return "iPad Pro (11-inch) ";
    if (iMachine == "iPad8,2") return "iPad Pro (11-inch) ";
    if (iMachine == "iPad8,3") return "iPad Pro (11-inch) ";
    if (iMachine == "iPad8,4") return "iPad Pro (11-inch) ";
    if (iMachine == "iPad8,5") return "iPad Pro 3 (12.9-inch) ";
    if (iMachine == "iPad8,6") return "iPad Pro 3 (12.9-inch) ";
    if (iMachine == "iPad8,7") return "iPad Pro 3 (12.9-inch) ";
    if (iMachine == "iPad8,8") return "iPad Pro 3 (12.9-inch) ";
    if (iMachine == "iPad8,9") return "iPad Pro 2 (11-inch) ";
    if (iMachine == "iPad8,10") return "iPad Pro 2 (11-inch) ";
    if (iMachine == "iPad8,11") return "iPad Pro 4 (12.9-inch) ";
    if (iMachine == "iPad8,12") return "iPad Pro 4 (12.9-inch) ";
    if (iMachine == "iPad11,1") return "iPad mini 5";
    if (iMachine == "iPad11,2") return "iPad mini 5";
    if (iMachine == "iPad11,3") return "iPad Air 3";
    if (iMachine == "iPad11,4") return "iPad Air 3";
    if (iMachine == "iPad11,6") return "iPad 8";
    if (iMachine == "iPad11,7") return "iPad 8";
    if (iMachine == "iPad12,1") return "iPad 9";
    if (iMachine == "iPad12,2") return "iPad 9";
    if (iMachine == "iPad13,1") return "iPad Air 4";
    if (iMachine == "iPad13,2") return "iPad Air 4";
    if (iMachine == "iPad13,4") return "iPad Pro 4 (11-inch) ";
    if (iMachine == "iPad13,5") return "iPad Pro 4 (11-inch) ";
    if (iMachine == "iPad13,6") return "iPad Pro 4 (11-inch) ";
    if (iMachine == "iPad13,7") return "iPad Pro 4 (11-inch) ";
    if (iMachine == "iPad13,8") return "iPad Pro 5 (12.9-inch) ";
    if (iMachine == "iPad13,9") return "iPad Pro 5 (12.9-inch) ";
    if (iMachine == "iPad13,10") return "iPad Pro 5 (12.9-inch) ";
    if (iMachine == "iPad13,11") return "iPad Pro 5 (12.9-inch) ";
    if (iMachine == "iPad14,1") return "iPad mini 6";
    if (iMachine == "iPad14,2") return "iPad mini 6";

    // 其他
    if (iMachine == "i386") return "iPhone Simulator";
    if (iMachine == "x86_64") return "iPhone Simulator";

    return iMachine;
  }
}