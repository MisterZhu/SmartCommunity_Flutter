import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../Network/sc_http_manager.dart';
import '../../../Network/sc_url.dart';
import '../Model/sc_message_card_model.dart';

class SCMessageController extends GetxController {
  /// 全部消息列表的indexId
  int? indexId;

  /// 未读消息列表的indexId
  int? unreadIndexId;

  /// 当前tab的index
  int currentIndex = 0;

  /// 全部消息列表数据
  List<SCMessageCardModel> allDataList = [];

  /// 未读消息列表数据
  List<SCMessageCardModel> unreadDataList = [];

  /// 是否显示更多弹窗，默认不显示
  bool showMoreDialog = false;

  /// 数据加载完成
  bool loadCompleted1 = false;

  /// 数据加载完成
  bool loadCompleted2 = false;

  @override
  onInit() {
    super.onInit();
    loadAllData(isMore: false);
    loadUnreadData(isMore: false);
  }

  /// 更新currentIndex
  updateCurrentIndex(int value) {
    currentIndex = value;
    update;
  }

  /// 更新弹窗显示状态
  updateMoreDialogStatus() {
    showMoreDialog = !showMoreDialog;
    update();
  }

  /// 全部消息数据
  loadAllData({bool? isMore, Function(bool success)? completeHandler}) {
    bool isLoadMore = isMore ?? false;
    // 是否需要传参数
    bool needParams = false;
    if (isLoadMore == true) {
      if (indexId != null) {
        needParams = true;
      }
    } else {
      SCLoadingUtils.show();
    }
    SCHttpManager.instance.get(
        url: SCUrl.kMessageListUrl,
        params: needParams == true ? {"indexId": indexId} : null,
        success: (value) {
          SCLoadingUtils.hide();
          loadCompleted1 = true;
          if (value['infoList'] != null) {
            List list = value['infoList'];
            indexId = value['indexId'];
            if (isLoadMore == true) {
              allDataList.addAll(List<SCMessageCardModel>.from(
                  list.map((e) => SCMessageCardModel.fromJson(e)).toList()));
            } else {
              allDataList = List<SCMessageCardModel>.from(
                  list.map((e) => SCMessageCardModel.fromJson(e)).toList());
            }
          } else {
            if (isLoadMore == true) {

            } else {
              allDataList = [];
            }
          }
          update();
          completeHandler?.call(true);
        },
        failure: (value) {
          loadCompleted1 = true;
          SCToast.showTip(value['message']);
          completeHandler?.call(false);
        });
  }

  /// 未读消息数据
  loadUnreadData({bool? isMore, Function(bool success)? completeHandler}) {
    bool isLoadMore = isMore ?? false;
    Map<String, dynamic> params = {"checked": false};
    if (isLoadMore == true) {
      if (unreadIndexId != null) {
        params = {"checked": false, "indexId": unreadIndexId};
      }
    } else {
      SCLoadingUtils.show();
    }
    SCHttpManager.instance.get(
        url: SCUrl.kMessageListUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          loadCompleted2 = true;
          if (value['infoList'] != null) {
            List list = value['infoList'];
            unreadIndexId = value['indexId'];
            if (isLoadMore == true) {
              unreadDataList.addAll(List<SCMessageCardModel>.from(
                  list.map((e) => SCMessageCardModel.fromJson(e)).toList()));
            } else {
              unreadDataList = List<SCMessageCardModel>.from(
                  list.map((e) => SCMessageCardModel.fromJson(e)).toList());
            }
          } else {
            if (isLoadMore == true) {

            } else {
              unreadDataList = [];
            }
          }
          update();
          completeHandler?.call(true);
        },
        failure: (value) {
          loadCompleted2 = true;
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
          update();
        },
        failure: (value) {
        });
  }

  /// 全部清空/全部已读接口
  deleteMessage({bool? allClear, bool? allRead, String? noticeId, Function(bool success)? completeHandler}) {
    Map<String, dynamic> params = {};

    if (allClear != null) {
      params.addAll({"allClear": allClear});
    }
    if (allRead != null) {
      params.addAll({"allRead": allRead});
    }
    if (noticeId != null) {
      params.addAll({"noticeId": noticeId});
    }
    SCHttpManager.instance.delete(
        url: SCUrl.kMessageDetailUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          completeHandler?.call(true);
        },
        failure: (value) {
          SCToast.showTip(value['message']);
          completeHandler?.call(false);
        });
  }
}