
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../network/sc_http_manager.dart';
import '../../../network/sc_url.dart';
import '../../../utils/Loading/sc_loading_utils.dart';
import '../../../utils/Toast/sc_toast.dart';

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

  /// 更新开关的状态
  updateSwitchStatus({required int index ,required bool enable}) {
    switchStatusList[index] = enable;
    update();
  }

  /// 退出登录
  logout({required Function(bool success) resultHandler}) {
    SCLoadingUtils.show();
    SCHttpManager.instance.delete(
        url: SCUrl.kLogoutUrl,
        params: null,
        success: (value) {
          SCLoadingUtils.success(text:'退出登录成功');
          resultHandler(true);
        },
        failure: (value) {
          if (value['message'] != null) {
            String message = value['message'];
            SCToast.showTip(message);
          }
          resultHandler(false);
        });
  }

}