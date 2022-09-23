import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smartcommunity/page/Service/View/sc_service_app_item.dart';

import '../GetXController/sc_service_controller.dart';
import '../Model/sc_service_module_model.dart';

class SCServiceRightListView extends StatefulWidget {
  SCServiceRightListView(
      {Key? key,
      this.section = 0,
      required this.list,
      this.pageChanged,
      this.appTapAction})
      : super(key: key);

  final int section;

  final List<SCServiceModuleModel>? list;

  /// icon按钮点击事件
  final Function(String title)? appTapAction;

  /// 页面切换
  final Function(int index)? pageChanged;

  @override
  SCServiceRightListViewState createState() => SCServiceRightListViewState();
}

class SCServiceRightListViewState extends State<SCServiceRightListView> {

  @override
  Widget build(BuildContext context) {
    SCServiceController state = Get.find<SCServiceController>();
    return PageView(
        scrollDirection: Axis.vertical,
        physics: const RangeMaintainingScrollPhysics(),
        children: gridViews(),
        onPageChanged: (index) {
          if (widget.pageChanged != null) {
            widget.pageChanged?.call(index);
          }
          state.updateCurrentIndex(index: index);
        }
    );
  }

  gridViews() {
    List<Widget> list = [];
    for (var i = 0; i < widget.list!.length; i++) {
      SCServiceModuleModel moduleModel = widget.list![i];
      list.add(gridViewItem(moduleModel));
    }
    return list;
  }

  Widget gridViewItem(SCServiceModuleModel moduleModel) {
    return StaggeredGridView.countBuilder(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 14.0, bottom: 100.0),
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 10.0,
        crossAxisCount: 3,
        shrinkWrap: true,
        itemCount: moduleModel.applets?.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          Applets applets = moduleModel.applets![index];
          return SCServiceAppItem(
            isRegularApp: false,
            section: 1,
            applets: applets,
            appTapAction: (title) {
              if (widget.appTapAction != null) {
                widget.appTapAction?.call(title);
              }
            },
          );
        },
        staggeredTileBuilder: (int index) {
          return const StaggeredTile.fit(1);
        });
  }

}
