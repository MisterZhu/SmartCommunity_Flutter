
import 'package:smartcommunity/constants/sc_enum.dart';
import 'package:smartcommunity/network/sc_base_api.dart';
import 'package:smartcommunity/network/sc_config.dart';

class SCNewBaseApi implements SCBaseApi {

  String baseUrl = '';

  SCHttpMethod method = SCHttpMethod.get;

  dynamic params = {};

  @override
  initMethod(SCHttpMethod httpMethod) {
    method = httpMethod;
  }

  @override
  initParams(value) {
    params = value;
  }

  @override
  initUrl(String url) {
    baseUrl = SCConfig.BASE_URL + url;
  }

  @override
  request() {

  }

}