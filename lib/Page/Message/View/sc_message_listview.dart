import 'package:flutter/material.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Page/Message/View/sc_message_card_cell.dart';

/// 消息listview
class SCMessageListView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return SCMessageCardCell(
            type: index,
            title: '交易提醒',
            icon: SCAsset.iconMessageType,
            time: '2023-01-22',
            content: '订单状态更新',
            contentDesc: '交易金额',
            contentIcon: SCAsset.iconMessageContentDefault,
            money: 300.00,
            bottomContentList: [{'title': '订单编号', 'content': '12345678901111'}, {'title': '备注', 'content': '已关闭'}],
            detailTapAction: (index) {

            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 10.0,);
        },
        itemCount: 5);
  }

}