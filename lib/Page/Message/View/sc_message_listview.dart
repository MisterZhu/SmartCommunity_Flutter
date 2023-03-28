import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import '../Controller/sc_message_controller.dart';
import '../Model/sc_message_model.dart';

/// 消息listview
class SCMessageListView extends StatelessWidget {

  /// SCMessageController
  final SCMessageController state;

  SCMessageListView({Key? key, required this.state}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          //SCMessageModel model = state.dataList[index];
          return SCMessageCardCell(
            type: index,
            title: '交易提醒标题最长是否',
            icon: SCAsset.iconMessageType,
            time: '2023-01-22',
            content: '订单状态更新',
            contentDesc: '交易金额',
            contentIcon: SCAsset.iconMessageContentDefault,
            money: 300.00,
            bottomContentList: [{'title': '订单编号', 'content': '12345678901111'}, {'title': '备注', 'content': '已关闭'}],
            detailTapAction: () {

            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 10.0,);
        },
        itemCount: 5);
  }

}