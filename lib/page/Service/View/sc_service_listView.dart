
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smartcommunity/page/Service/View/sc_service_cell_item.dart';

import '../GetXController/sc_service_controller.dart';

class SCServiceListView extends StatelessWidget {

  List headerList = ['首页应用', '物业管家', '智慧应用', '社区应用', '购物应用'];

  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    SCServiceController state = Get.find<SCServiceController>();
    return ListView.separated(
        padding: const EdgeInsets.only(top: 8, left: 0, right: 0, bottom: 34),
        itemBuilder: (BuildContext context, int index) {
          return SCServiceCellItem(
            section: index,
            headerTitle: headerList[index],
            isShowEditBtn: index == 0 ? true : false,
            list: state.appList,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 8,);
        },
        itemCount: headerList.length);
  }

}