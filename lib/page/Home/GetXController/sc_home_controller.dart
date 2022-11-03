
import 'package:get/get.dart';
import 'package:smartcommunity/page/Home/GetXController/sc_home_controller1.dart';
import 'package:smartcommunity/page/Home/GetXController/sc_home_controller2.dart';
import 'package:smartcommunity/page/Home/GetXController/sc_home_nav1_controller.dart';

import '../../Mine/Model/sc_my_house_model.dart';
import '../../Service/GetXController/sc_service_controller.dart';

class SCHomeController extends GetxController {
  /// 皮肤样式,默认第一套
  int skinStyle = 0;

  /// 切换皮肤
  changeSkin({required int style}) {
    SCServiceController serviceState = Get.find<SCServiceController>();
    serviceState.changeSkin(style: style);
    skinStyle = style;
    if (style == 0) {
      SCHomeController1 state = Get.find<SCHomeController1>();
      state.resetAllData();
    } else {
      SCHomeController2 state = Get.find<SCHomeController2>();
      state.resetAllData();
    }
    update();
  }

  /// 切换房屋
  changeHouse({required SCMyHouseModel? model}) {
    SCHomeController1 state1 = Get.find<SCHomeController1>();
    SCHomeController2 state2 = Get.find<SCHomeController2>();
    SCHomeNav1Controller nav1State = Get.find<SCHomeNav1Controller>();

    state1.update();
    state2.changeCommunityName(name: model?.communityName ?? '');
    nav1State.changeCommunityName(name: model?.communityName ?? '');
  }
}