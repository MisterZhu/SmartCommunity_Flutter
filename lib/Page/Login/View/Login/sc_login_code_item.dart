
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';

/// 方框验证码item
class SCLoginCodeItem extends StatelessWidget {
  SCLoginCodeItem({Key? key, required this.numberList,
  }) : super(key: key);

  final List<int>? numberList;

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Container(
      height: 52.0,
      alignment: Alignment.center,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return cellItem(index);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              width: 8.0,
            );
          },
          itemCount: 6),
    );
  }

  /// 单个方框验证码
  Widget cellItem(int index) {
    String? value = '';
    var list = numberList ?? [];
    if (list.isNotEmpty) {
      int count = numberList?.length ?? 0;
      if (count > index) {
        value = '${list[index]}';
      }
    }
    return Container(
      width: 48.0,
      height: 52.0,
      alignment: Alignment.center,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: numberList?.length == index ? SCColors.color_FFFFFF : SCColors.color_F3F3F3,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: numberList?.length == index ? SCColors.color_1B1D33 : SCColors.color_F3F3F3, width: 0.5)
      ),
      child: Text(
        value,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: SCFonts.f28,
          fontWeight: FontWeight.w500,
          color: SCColors.color_1B1C33,
        ),
      )
    );
  }
}