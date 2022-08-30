import 'package:flutter/material.dart';

/// 首页第二套皮肤-listview

class SCHomeListView2 extends StatelessWidget {

  const SCHomeListView2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          return testCell();
        },
        separatorBuilder: (BuildContext context, int index) {
          return lineWidget();
        },
        itemCount: 0);
  }

  /// 分割线
  Widget lineWidget() {
    return const SizedBox(
      height: 8.0,
    );
  }

  /// 测试-cell
  Widget testCell() {
    return Container(
      color: Colors.yellowAccent,
      height: 200,
    );
  }
}
