
import 'dart:developer';

import 'package:smartcommunity/network/sc_new_base_api.dart';

class SCGeoCodeApi extends SCNewBaseApi {
  @override
  initUrl(String url) {
  }

  startRequest() {
    log('URL:$baseUrl');
  }
}