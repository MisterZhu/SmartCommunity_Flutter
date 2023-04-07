import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Utils/Date/sc_date_utils.dart';
import '../../../Network/sc_config.dart';
import '../Controller/sc_message_controller.dart';
import '../Model/sc_message_card_model.dart';

/// 消息listview
class SCMessageListView extends StatelessWidget {

  /// SCMessageController
  final SCMessageController state;

  /// RefreshController
  final RefreshController refreshController;

  SCMessageListView({Key? key, required this.state, required this.refreshController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        enablePullDown: true,
        header: const SCCustomHeader(
          style: SCCustomHeaderStyle.noNavigation,
        ),
        onRefresh: onRefresh,
        onLoading: loadMore,
        child: state.dataList.isNotEmpty ? listView() : emptyView()
    );
  }


  Widget listView() {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          SCMessageCardModel model = state.dataList[index];
          List list = [];
          int type = 0;  /// 类型,0-只显示一行内容,1-显示两行内容,2-显示图片+内容+内容描述
          /// noticeCardType卡片类型 1:数据卡片形式; 2:文章消息卡片
          if (model.noticeCardType == 2) { // 2:文章消息卡片
            type = 2; // 2-显示图片+内容+内容描述
          }
          String head = '';
          String content = '';
          if (model.displayItems != null) {
            if (model.displayItems!.isNotEmpty) {
              List displayItems = model.displayItems!;
              DisplayItems firstItem = displayItems.first;
              if (firstItem.noticeConsumerMobileCardItemDisplayType == 1) {//1值换行+加粗
                type == 1;
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
            type: type,
            title: model.title,
            icon: model.icon?.fileKey != null ? SCConfig.getImageUrl(model.icon?.fileKey ?? '') : SCAsset.iconMessageType,
            time: SCDateUtils.relativeDateFormat(DateTime.parse(model.noticeTime ?? '')),
            head: head,
            content: content,
            contentIcon: model.linkImage?.fileKey != null ? SCConfig.getImageUrl(model.linkImage?.fileKey ?? '') : SCAsset.iconMessageContentDefault,
            bottomContentList: list,
            detailTapAction: () {
              if (model.noticeArriveId != null) {
                state.loadDetailData(model.noticeArriveId!);
              }
              if (model.jumpDetail == true && model.noticeCardType == 2) {
                /// 可以跳转到详情 且 是文章消息卡片
              }
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 10.0,);
        },
        itemCount: state.dataList.length);
  }


  /// emptyView
  Widget emptyView() {
    if (state.loadCompleted == true) {
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
    state.loadData(
        isMore: false,
        completeHandler: (bool success) {
          refreshController.refreshCompleted();
          refreshController.loadComplete();
        });
  }

  /// 上拉加载
  void loadMore() async {
    state.loadData(
        isMore: true,
        completeHandler: (bool success) {
          refreshController.loadComplete();
        });
  }

}