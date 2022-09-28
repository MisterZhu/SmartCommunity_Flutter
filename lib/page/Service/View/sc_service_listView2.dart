import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/page/Service/GetXController/sc_service_controller.dart';

import 'package:smartcommunity/page/Service/Model/sc_service_module_model.dart';
import 'package:smartcommunity/page/Service/View/sc_service_cell_item.dart';
import 'package:smartcommunity/page/Service/View/sc_service_left_listView.dart';
import 'mj_service_right_listView.dart';

/// 应用列表-第二套皮肤
class SCServiceListView2 extends StatelessWidget {
  final SCServiceModuleModel model;

  final List<SCServiceModuleModel> appList;

  /// 按钮点击事件
  final Function(String title)? itemTapAction;

  const SCServiceListView2(
      {Key? key,
      required this.model,
      required this.appList,
      this.itemTapAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        topItem(),
        const SizedBox(
          height: 8.0,
        ),
        bottomItem(),
      ],
    );
  }

  /// 顶部组件
  Widget topItem() {
    return SCServiceCellItem(
      section: 0,
      moduleModel: model,
      tapAction: (title) {
        itemTapAction?.call(title);
      },
    );
  }

  /// 底部组件
  Widget bottomItem() {
    return Expanded(
        child: Container(
          color: SCColors.color_FFFFFF,
          child: Row(
            children: [leftTitleItem(), rightItem()],
          ),
        ));
  }

  /// 底部组件-左侧标题
  Widget leftTitleItem() {
    List<String> tabList = [];
    for (var element in appList) {
      // element 为list内的每个元素
      tabList.add(element.module?.name ?? '');
    }
    // widget.appList!.map((moduleModule) => moduleModule.module?.name).toList();
    return Container(
      width: 99.0,
      color: SCColors.color_F6F6F6,
      child: GetBuilder<SCServiceController>(builder: (state){
        return SCServiceLeftListView(
          currentItemIndex: state.currentIndex,
          list: tabList,
          leftItemTap: (index) {},
        );
      }),
    );
  }

  /// 底部组件-右侧应用列表
  Widget rightItem() {
    return Expanded(
        child: Container(
      alignment: Alignment.topLeft,
      child: SCServiceRightListView(
        list: appList,
        pageChanged: (int index) {

        },
      ),
    ));
  }
}
