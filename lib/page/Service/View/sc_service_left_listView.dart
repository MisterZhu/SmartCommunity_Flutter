import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:smartcommunity/constants/sc_fonts.dart';

import '../../../constants/sc_colors.dart';

class SCServiceLeftListView extends StatefulWidget {
  SCServiceLeftListView({
      Key? key,
      required this.list,
      this.itemHeight = 60.0,
      this.itemTapAction})
  : super(key: key);

  final List<String> list;
  final double itemHeight;
  final Function(int index)? itemTapAction;

  @override
  SCServiceLeftListViewState createState() => SCServiceLeftListViewState();
}

class SCServiceLeftListViewState extends State<SCServiceLeftListView> with SingleTickerProviderStateMixin{
  late Animation<double> animation;
  late AnimationController animationController;
  int currentItemIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    animation = Tween(begin: 0.0, end: 0.0).animate(animationController);
    animationController.addListener(() {
      if (mounted) {
        setState(() {

        });
      }
    });
    animationController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
    if (widget.itemTapAction != null) {
      widget.itemTapAction?.call(index);
    }
    moveToItem(index);
  }

  moveToItem(int index) {
    double begin = currentItemIndex * widget.itemHeight;
    double end = index *widget.itemHeight;
    animation = Tween(begin: begin, end: end).animate(CurvedAnimation(parent: animationController, curve: Curves.linear));
    animationController.addStatusListener((status) {
      if (AnimationStatus.completed == status) {
        currentItemIndex = index;
      }
    });
    animationController.forward(from: 0.0);
  }
}
