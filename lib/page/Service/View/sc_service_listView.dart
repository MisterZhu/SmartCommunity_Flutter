
import 'dart:developer';
import 'package:flutter/cupertino.dart';

import 'package:smartcommunity/page/Service/Model/sc_service_module_model.dart';
import 'package:smartcommunity/page/Service/View/sc_service_cell_item.dart';

class SCServiceListView extends StatelessWidget {

  final List<SCServiceModuleModel>? appList;

  /// 按钮点击事件
  final Function(String title)? itemTapAction;

  SCServiceListView({Key? key, this.appList, this.itemTapAction}) : super(key: key);


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