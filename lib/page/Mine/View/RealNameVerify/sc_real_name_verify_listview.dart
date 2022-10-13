
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../constants/sc_colors.dart';
import '../../../../constants/sc_fonts.dart';

/// 实名认证listview

class SCRealNameVerifyListView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //listView(),
        btnItem(),
      ],
    );
  }

  /// body
  Widget listView() {
    return ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return getCell(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container();
        },
        itemCount: 4);
  }

  Widget getCell(int index) {
    return Container();
  }

  Widget btnItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        width: double.infinity,
        height: 48.0,
        child: CupertinoButton(
            padding: EdgeInsets.zero,
            color: SCColors.color_FF6C00,
            borderRadius: BorderRadius.circular(8.0),
            child: const Text(
              '去认证',
              style: TextStyle(
                fontSize: SCFonts.f16,
                fontWeight: FontWeight.w500,
                color: SCColors.color_FFFFFF,
              ),
            ),
            onPressed: () {

            }),
      ),
    );
  }
}