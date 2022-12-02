
import 'dart:developer';
import 'package:flutter/cupertino.dart';

import 'package:smartcommunity/Page/Service/Model/sc_service_module_model.dart';
import 'package:smartcommunity/Page/Service/View/sc_service_cell_item.dart';

/// 应用列表-第一套皮肤

class SCServiceListView1 extends StatelessWidget {

  final List<SCServiceModuleModel>? appList;

  /// 按钮点击事件
  final Function(String title)? itemTapAction;

  SCServiceListView1({Key? key, required this.appList, this.itemTapAction}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return ListView.separated(
        padding: const EdgeInsets.only(top: 10, left: 0, right: 0, bottom: 34),
        itemBuilder: (BuildContext context, int index) {
          SCServiceModuleModel moduleModel = appList![index];
          return SCServiceCellItem(
            section: index,
            moduleModel: moduleModel,
            tapAction: (title){
              if (itemTapAction != null) {
                itemTapAction?.call(title);
              }
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 8,);
        },
        itemCount: appList!.length);
  }

}