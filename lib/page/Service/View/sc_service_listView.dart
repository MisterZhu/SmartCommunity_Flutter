
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smartcommunity/page/Service/Model/sc_service_module_model.dart';
import 'package:smartcommunity/page/Service/View/sc_service_cell_item.dart';

import '../GetXController/sc_service_controller.dart';

class SCServiceListView extends StatelessWidget {

  SCServiceListView({Key? key, this.appList}) : super(key: key);

  final List<SCServiceModuleModel>? appList;

  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return ListView.separated(
        padding: const EdgeInsets.only(top: 8, left: 0, right: 0, bottom: 34),
        itemBuilder: (BuildContext context, int index) {
          SCServiceModuleModel moduleModel = appList![index];
          return SCServiceCellItem(
            section: index,
            moduleModel: moduleModel,
            isShowEditBtn: moduleModel.module?.id == 0 ? true : false, /// 如果是常用应用显示右边的编辑
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 8,);
        },
        itemCount: appList!.length);
  }

}