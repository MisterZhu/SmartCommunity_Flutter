import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../Network/sc_http_manager.dart';
import '../../../Network/sc_url.dart';
import '../Model/sc_message_model.dart';

class SCMessageController extends GetxController {

  int pageNum = 1;

  List<SCMessageModel> dataList = [];

  @override
  onInit() {
    super.onInit();
    loadData(isMore: false);
  }

  loadData({bool? isMore, Function(bool success, bool last)? completeHandler}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      pageNum++;
    } else {
      pageNum = 1;
      SCLoadingUtils.show();
    }
    var params = {
      "conditions": {
        "isRead": 0,
        "title": "",
        "typeId": ""
      },
      "count": false,
      "last": false,
      "orderBy": [
        {
          "asc": true,
          "field": ""
        }
      ],
      "pageNum": pageNum,
      "pageSize": 20
    };
    SCHttpManager.instance.post(
        url: SCUrl.kMessageListUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          List list = value['records'];
          if (isLoadMore == true) {
            dataList.addAll(List<SCMessageModel>.from(
                list.map((e) => SCMessageModel.fromJson(e)).toList()));
          } else {
            dataList = List<SCMessageModel>.from(
                list.map((e) => SCMessageModel.fromJson(e)).toList());
          }
          update();
          bool last = false;
          if (isLoadMore) {
            last = value['last'];
          }
          completeHandler?.call(true, last);
        },
        failure: (value) {
          if (isLoadMore) {
            pageNum--;
          }
          SCToast.showTip(value['message']);
          completeHandler?.call(false, false);
        });
  }

}