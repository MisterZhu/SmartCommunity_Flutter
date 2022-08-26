import 'package:get/get.dart';
import 'package:smartcommunity/page/Guide/GetXController/sc_base_privacy_controller.dart';
import 'package:smartcommunity/page/Home/GetXController/sc_home_controller.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_select_city_controller.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_search_city_controller.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_login_controller.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_select_community_controller.dart';
import 'package:smartcommunity/page/Mine/GetXController/sc_mine_controller.dart';
import 'package:smartcommunity/page/Service/GetXController/sc_service_controller.dart';

import '../page/Login/GetXController/sc_search_community_controller.dart';

/// 首页-binding
class SCAllBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SCHomeController>(() => SCHomeController());
    Get.lazyPut<SCMineController>(() => SCMineController());
    Get.lazyPut<SCBasePrivacyController>(() => SCBasePrivacyController());
    Get.lazyPut<SCLoginController>(() => SCLoginController());
    Get.lazyPut<SCSelectCityController>(() => SCSelectCityController());
    Get.lazyPut<SCSearchCityController>(() => SCSearchCityController());
    Get.lazyPut<SCSelectCommunityController>(() => SCSelectCommunityController());
    Get.lazyPut<SCSearchCommunityController>(() => SCSearchCommunityController());
    Get.lazyPut<SCServiceController>(() => SCServiceController());
  }
}