
import 'package:smartcommunity/constants/sc_enum.dart';
import 'package:smartcommunity/network/sc_base_api.dart';
import 'package:smartcommunity/network/sc_config.dart';

class SCNewBaseApi extends SCBaseApi {

  String baseUrl = '';

  @override
  SCHttpMethod method(SCHttpMethod method) {
    return SCHttpMethod.get;
  }

  @override
  params(params) {
    return {};
  }

  @override
  String url(String url) {
    baseUrl = SCConfig.BASE_URL + url;
    return baseUrl;
  }

}