
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:smartcommunity/constants/sc_colors.dart';

import 'package:smartcommunity/page/Service/Model/sc_service_module_model.dart';
import 'package:smartcommunity/page/Service/View/sc_service_app_item.dart';
import 'package:smartcommunity/page/Service/View/sc_service_cell_item.dart';
import 'package:smartcommunity/page/Service/View/sc_service_left_listView.dart';
import 'package:smartcommunity/utils/sc_utils.dart';

import '../../../constants/sc_fonts.dart';
import 'mj_service_right_listView.dart';

class SCServiceListView2 extends StatefulWidget {

  final SCServiceModuleModel regularModuleModel;

  final List<SCServiceModuleModel>? appList;

  /// 按钮点击事件
  final Function(String title)? itemTapAction;

  SCServiceListView2({Key? key, required this.regularModuleModel, required this.appList, this.itemTapAction})
      : super(key: key);

  @override
  SCServiceListView2State createState() => SCServiceListView2State();
}


class SCServiceListView2State extends State<SCServiceListView2> with SingleTickerProviderStateMixin {

  double rightHeight = SCUtils().getScreenHeight();

  late TabController tabController;

  @override
  initState() {
    super.initState();
    tabController = TabController(length: widget.appList!.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        regularAppGroupItem(),
        const SizedBox(height: 8.0,),
        Expanded(
            child: Container(color: SCColors.color_FFFFFF, child: bottomItem(),)
        ),
      ],
    );
  }

  Widget regularAppGroupItem() {
    return SCServiceCellItem(
      section: 0,
      moduleModel: widget.regularModuleModel,
      tapAction: (title){
        if (widget.itemTapAction != null) {
          widget.itemTapAction?.call(title);
        }
      },
    );
  }

  Widget bottomItem() {
    return Row(
      children: [
        leftTitleItem(),
        Expanded(
            child: Align(
              alignment: Alignment.topLeft,
              child: SCServiceRightListView(
                section: 1,
                list: widget.appList,
                appTapAction: (title) {

                },
                pageChanged: (index){

                }),
            ))
      ],
    );
  }

  Widget leftTitleItem() {
    List<String> tabList = [];
    widget.appList?.forEach((element) {
      // element 为list内的每个元素
      tabList.add(element.module?.name?? '');
    });
    // widget.appList!.map((moduleModule) => moduleModule.module?.name).toList();
    return Container(
      width: 99.0,
      color: SCColors.color_F6F6F6,
      child: SCServiceLeftListView(list: tabList, itemTapAction: (index) {

      },),
    );
  }

}