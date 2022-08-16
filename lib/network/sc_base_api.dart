
import 'package:smartcommunity/constants/sc_enum.dart';

abstract class SCBaseApi {

  /// url
  String url(String url);

  /// method
  SCHttpMethod method(SCHttpMethod method);

  /// params
  dynamic params(dynamic params);
}