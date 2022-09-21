
import 'dart:developer';
import 'package:flutter/cupertino.dart';

import 'package:smartcommunity/page/Service/Model/sc_service_module_model.dart';
import 'package:smartcommunity/page/Service/View/sc_service_cell_item.dart';

class SCServiceListView2 extends StatelessWidget {

  final List<SCServiceModuleModel>? appList;

  /// 按钮点击事件
  final Function(String title)? itemTapAction;

  SCServiceListView2({Key? key, this.appList, this.itemTapAction}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return Column(
      children: [
        regularAppGroupItem(),
        const SizedBox(height: 8.0,),
      ],
    );
  }

  Widget regularAppGroupItem() {
    SCServiceModuleModel moduleModel = appList![0];
    return SCServiceCellItem(
      section: 0,
      moduleModel: moduleModel,
      tapAction: (title){
        if (itemTapAction != null) {
          itemTapAction?.call(title);
        }
      },
    );
  }


}