import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smartcommunity/page/Service/View/sc_service_app_item.dart';
import '../GetXController/sc_service_controller.dart';
import '../Model/sc_service_module_model.dart';

/// 应用列表第二套皮肤-右侧的应用列表
class SCServiceRightListView extends StatelessWidget {

  SCServiceRightListView(
      {Key? key,
        required this.list,
        this.section = 0,
        this.appTapAction})
      : super(key: key);

  final int section;

  final List<SCServiceModuleModel> list;

  /// icon按钮点击事件
  final Function(String title)? appTapAction;

  SCServiceController state = Get.find<SCServiceController>();

  @override
  Widget build(BuildContext context) {
    return PageView(
        controller: state.pageController,
        scrollDirection: Axis.vertical,
        children: gridViews(),
        onPageChanged: (index) {
          state.updateCurrentIndex(index: index);
        });
  }

  gridViews() {
    List<Widget> widgetList = [];
    int count = list.length;
    for (var i = 0; i < count; i++) {
      SCServiceModuleModel moduleModel = list[i];
      widgetList.add(gridViewItem(moduleModel));
    }
    return widgetList;
  }

  Widget gridViewItem(SCServiceModuleModel moduleModel) {
    ScrollController scrollController = ScrollController();
    scrollNotify(scrollController);

    return SingleChildScrollView(
      controller: scrollController,
      child: StaggeredGridView.countBuilder(
          primary: true,
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 14.0, bottom: 0.0),
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
                appTapAction?.call(title);
              },
            );
          },
          staggeredTileBuilder: (int index) {
            return const StaggeredTile.fit(1);
          }),
    );
  }

  /// 滑动监听
  scrollNotify(ScrollController scrollController) {
    scrollController.addListener(() {
      if (scrollController.offset < scrollController.position.minScrollExtent &&
          scrollController.offset < -60.0) {
        /// 上一页
        if (state.currentIndex > 0) {
          scrollController.jumpTo(0);
          state.pageController.previousPage(
              duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
        }
      }
      if (scrollController.offset > scrollController.position.maxScrollExtent &&
          scrollController.offset >
              (scrollController.position.maxScrollExtent + 60.0)) {
        /// 下一页
        int maxLength = list.length;
        if (state.currentIndex < maxLength - 1) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
          state.pageController.nextPage(
              duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
        }
      }
    });
  }
}
