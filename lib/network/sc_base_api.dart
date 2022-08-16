
import 'package:smartcommunity/constants/sc_enum.dart';

abstract class SCBaseApi {

  /// url
  initUrl(String url);

  /// method
  initMethod(SCHttpMethod method);

  /// params
  initParams(dynamic params);

  /// 发起网络请求
  request();
}