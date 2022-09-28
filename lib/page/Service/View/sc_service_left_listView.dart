import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smartcommunity/constants/sc_fonts.dart';

import '../../../constants/sc_colors.dart';
import '../GetXController/sc_service_controller.dart';

class SCServiceLeftListView extends StatefulWidget {
  SCServiceLeftListView({
      Key? key,
      required this.list,
      this.itemHeight = 60.0,
      this.currentItemIndex = 0,
      this.leftItemTap})
  : super(key: key);

  final List<String> list;
  final double itemHeight;
  final Function(int index)? leftItemTap;
  final int currentItemIndex;

  @override
  SCServiceLeftListViewState createState() => SCServiceLeftListViewState();
}

class SCServiceLeftListViewState extends State<SCServiceLeftListView> with SingleTickerProviderStateMixin{

  int currentItemIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    currentItemIndex = widget.currentItemIndex;
    // TODO: implement build
    return Container(
      alignment: Alignment.topCenter,
      width: 99,
      child: listView(),
    );
  }

  Widget listView() {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.list.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () =>  itemTaped(index),
            child: Container(
              height: widget.itemHeight,
              alignment: Alignment.center,
              child: currentItemIndex == index ? selectedItem(index) : normalItem(index),
            ),
          );
        });
  }

  /*未选中的item*/
  Widget normalItem(int index) {
    return Container(
      color: SCColors.color_F5F5F5,
      alignment: Alignment.center,
      child: Text(
        widget.list[index],
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.w400,
          color: SCColors.color_5E5F66,
        ),
      ),
    );
  }

  /*选中的item*/
  Widget selectedItem(int index) {
    return Container(
      color: SCColors.color_FFFFFF,
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(child: Text(
            widget.list[index],
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w500,
              color: SCColors.color_1B1D33,
            ),
          )),
          Container(
            width: 2.0,
            height: 24.0,
            color: SCColors.color_FF6C00,

          )
        ],
      ),

    );
  }

  itemTaped(int index) {
    SCServiceController state = Get.find<SCServiceController>();
    if (widget.leftItemTap != null) {
      widget.leftItemTap?.call(index);
    }
    if (index != state.currentIndex) {
      state.pageController.jumpToPage(index);
      state.updateCurrentIndex(index: index);
    }
  }

}
