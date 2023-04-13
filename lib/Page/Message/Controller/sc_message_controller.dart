import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../Network/sc_http_manager.dart';
import '../../../Network/sc_url.dart';
import '../Model/sc_message_card_model.dart';

class SCMessageController extends GetxController {

  int? indexId;

  List<SCMessageCardModel> dataList = [];

  /// 数据加载完成
  bool loadCompleted = false;

  @override
  onInit() {
    super.onInit();
  }

  loadData({bool? isMore, Function(bool success)? completeHandler}) {
    bool isLoadMore = isMore ?? false;
    bool needIndexId = false;
    if (isLoadMore == true) {
      if (indexId != null) {
        needIndexId = true;
      }
    } else {
      SCLoadingUtils.show();
    }
    SCHttpManager.instance.get(
        url: SCUrl.kMessageListUrl,
        params: needIndexId ? {"indexId": indexId} : null,
        success: (value) {
          SCLoadingUtils.hide();
          loadCompleted = true;
          if (value['infoList'] != null) {
            List list = value['infoList'];
            indexId = value['indexId'];
            if (isLoadMore == true) {
              dataList.addAll(List<SCMessageCardModel>.from(
                  list.map((e) => SCMessageCardModel.fromJson(e)).toList()));
            } else {
              dataList = List<SCMessageCardModel>.from(
                  list.map((e) => SCMessageCardModel.fromJson(e)).toList());
            }
          }
          update();
          completeHandler?.call(true);
        },
        failure: (value) {
          loadCompleted = true;
          SCToast.showTip(value['message']);
          completeHandler?.call(false);
        });
  }

  /// 获取详情并更新为已读
  loadDetailData(int noticeArriveId) {
    SCHttpManager.instance.get(
        url: SCUrl.kMessageDetailUrl,
        params: {"noticeArriveId": noticeArriveId},
        success: (value) {
          SCLoadingUtils.hide();
          update();
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

}