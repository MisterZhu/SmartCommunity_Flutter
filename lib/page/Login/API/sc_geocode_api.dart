
import 'dart:developer';

import 'package:smartcommunity/network/sc_new_base_api.dart';

class SCGeoCodeApi extends SCNewBaseApi {
  @override
  String url(String url) {
    return 'login';
  }

  startRequest() {
    log('URL:$baseUrl');
  }
}