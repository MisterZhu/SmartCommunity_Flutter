import 'dart:developer';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SCToggleHousesController extends GetxController {

  int selectIndex = 0;

  updateSelectIndex(int index) {
    log('当前index========$index');
    selectIndex = index;
    update();
  }

}