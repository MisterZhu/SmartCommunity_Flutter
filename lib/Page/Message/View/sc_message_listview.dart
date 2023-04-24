import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import '../../../Network/sc_config.dart';
import '../../../Utils/Date/sc_date_utils.dart';
import '../../../Utils/Router/sc_router_helper.dart';
import '../../../Utils/Router/sc_router_path.dart';
import '../../../Utils/sc_utils.dart';
import '../Controller/sc_message_controller.dart';
import '../Model/sc_message_card_model.dart';

/// 消息listview
class SCMessageListView extends StatelessWidget {

  /// SCMessageController
  final SCMessageController state;

  /// 类型，0全部，1未读
  final int type;

  /// RefreshController
  final RefreshController refreshController;

  SCMessageListView({Key? key, required this.state, required this.type, required this.refreshController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<SCMessageCardModel> data = type == 1 ? state.unreadDataList : state.allDataList;
    return SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        enablePullDown: true,
        header: const SCCustomHeader(
          style: SCCustomHeaderStyle.noNavigation,
        ),
        onRefresh: onRefresh,
        onLoading: loadMore,
        child: data.isNotEmpty ? listView() : emptyView()
    );
  }

  Widget listView() {
    List<SCMessageCardModel> data = type == 1 ? state.unreadDataList : state.allDataList;
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          SCMessageCardModel model = data[index];
          List list = [];
          int cardType = 0;  // 卡片类型,0-只显示一行内容,1-显示两行内容,2-显示图片+内容+内容描述
          // noticeCardType卡片类型 1:数据卡片形式; 2:文章消息卡片
          if (model.noticeCardType == 2) { // 2:文章消息卡片
            cardType = 2; // 2-显示图片+内容+内容描述
          }
          String head = '';
          String content = '';
          if (model.displayItems != null) {
            if (model.displayItems!.isNotEmpty) {
              List displayItems = model.displayItems!;
              DisplayItems firstItem = displayItems.first;
              if (firstItem.noticeConsumerMobileCardItemDisplayType == 1) {//1值换行+加粗
                cardType == 1;
              }
              head = firstItem.head ?? '';
              content = firstItem.content ?? '';
              if (model.displayItems!.length > 1) {
                for (int i = 1; i < displayItems.length; i++) {
                  DisplayItems item = displayItems[i];
                  list.add({'title': item.head, 'content': item.content});
                }
              }
            }
          }
          return SCMessageCardCell(
            type: cardType,
            title: model.title,
            icon: model.icon?.fileKey != null ? SCConfig.getImageUrl(model.icon?.fileKey ?? '') : SCAsset.iconMessageType,
            time: SCDateUtils.relativeDateFormat(DateTime.parse(model.noticeTime ?? '')),
            isUnread: type == 1 ? true : false,
            head: head,
            content: content,
            contentIcon: model.linkImage?.fileKey != null ? SCConfig.getImageUrl(model.linkImage?.fileKey ?? '') : SCAsset.iconMessageContentDefault,
            bottomContentList: list,
            detailTapAction: () {
              if (model.ext != null) {
                var ext = jsonDecode(model.ext ?? '');
                if (ext['jumpUrl'] != null) {
                  if (model.cardCode == 'CONTENT_MESSAGE') {
                    // 跳转到站内信详情h5
                    String jumpUrl = SCConfig.getH5Url(ext['jumpUrl']);
                    String url = SCUtils.getWebViewUrl(url: jumpUrl, title: '详情',  needJointParams: true);
                    SCRouterHelper.pathPage(SCRouterPath.webViewPath, {'title' : '详情', 'url' : url});
                  }
                }
              }
              if (model.noticeArriveId != null) {
                state.loadDetailData(model.noticeArriveId!);
              }
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 10.0,);
        },
        itemCount: data.length);
  }
  /// emptyView
  Widget emptyView() {
    if ((type == 0 && state.loadCompleted1 == true) || (type == 1 && state.loadCompleted2 == true)) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 124.0,
          ),
          Image.asset(SCAsset.iconMessageEmpty, width: 120.0, height: 120.0,),
          const SizedBox(
            height: 2.0,
          ),
          const Text("暂无消息", style: TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: SCColors.color_8D8E99
          ),)
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  /// 下拉刷新
  Future onRefresh() async {
    if (state.currentIndex == 0) {
      state.loadAllData(
          isMore: false,
          completeHandler: (bool success) {
            refreshController.refreshCompleted();
            refreshController.loadComplete();
          });
    } else if (state.currentIndex == 1) {
      state.loadUnreadData(
          isMore: false,
          completeHandler: (bool success) {
            refreshController.refreshCompleted();
            refreshController.loadComplete();
          });
    }
  }

  /// 上拉加载
  void loadMore() async {
    if (state.currentIndex == 0) {
      state.loadAllData(
          isMore: true,
          completeHandler: (bool success) {
            refreshController.loadComplete();
          });
    } else if (state.currentIndex == 1) {
      state.loadUnreadData(
          isMore: true,
          completeHandler: (bool success) {
            refreshController.loadComplete();
          });
    }
  }

}