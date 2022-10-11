
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SCSettingController extends GetxController {

  bool switchStatus1 = false;

  bool switchStatus2 = false;

  List switchStatusList = [];

  @override
  onInit() {
    super.onInit();
    switchStatusList.add(switchStatus1);
    switchStatusList.add(switchStatus2);

  }


  updateSwitchStatus({required int index ,required bool enable}) {
    switchStatusList[index] = enable;
    update();
  }
}