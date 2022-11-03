import 'package:get/get.dart';
import 'package:smartcommunity/page/Base/Scan/Controller/sc_scan_controller.dart';
import 'package:smartcommunity/page/Guide/GetXController/sc_base_privacy_controller.dart';
import 'package:smartcommunity/page/Home/GetXController/sc_home_controller1.dart';
import 'package:smartcommunity/page/Home/GetXController/sc_home_nav1_controller.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_select_city_controller.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_search_city_controller.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_login_controller.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_select_community_controller.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_select_house_data_controller.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_select_house_search_status_controller.dart.dart';
import 'package:smartcommunity/page/Mine/GetXController/sc_mine_controller.dart';
import 'package:smartcommunity/page/Mine/GetXController/sc_personal_info_controller.dart';
import 'package:smartcommunity/page/Service/GetXController/sc_service_controller.dart';

import '../page/Guide/GetXController/sc_guide_controller.dart';
import '../page/Home/GetXController/sc_home_controller.dart';
import '../page/Home/GetXController/sc_home_controller2.dart';
import '../page/Login/GetXController/sc_search_community_controller.dart';

/// 首页-binding
class SCAllBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SCGuideController>(() => SCGuideController());
    Get.lazyPut<SCHomeController>(() => SCHomeController());
    Get.lazyPut<SCHomeController1>(() => SCHomeController1());
    Get.lazyPut<SCHomeController2>(() => SCHomeController2());
    Get.lazyPut<SCHomeNav1Controller>(() => SCHomeNav1Controller());
    Get.lazyPut<SCMineController>(() => SCMineController());
    Get.lazyPut<SCBasePrivacyController>(() => SCBasePrivacyController());
    Get.lazyPut<SCLoginController>(() => SCLoginController());
    Get.lazyPut<SCSelectCityController>(() => SCSelectCityController());
    Get.lazyPut<SCSearchCityController>(() => SCSearchCityController());
    Get.lazyPut<SCSelectCommunityController>(() => SCSelectCommunityController());
    Get.lazyPut<SCSearchCommunityController>(() => SCSearchCommunityController());
    Get.lazyPut<SCServiceController>(() => SCServiceController());
    Get.lazyPut<SCSelectHouseSearchStatusController>(() => SCSelectHouseSearchStatusController());
    Get.lazyPut<SCSelectHouseDataController>(() => SCSelectHouseDataController());
    Get.lazyPut<SCScanController>(() => SCScanController());
    Get.lazyPut<SCPersonalInfoController>(() => SCPersonalInfoController());
  }
}