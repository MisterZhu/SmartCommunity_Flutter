
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sc_uikit/sc_uikit.dart';

import '../../../../Constants/sc_asset.dart';

/// 自定义数字键盘
class SCNumberKeyboardItem extends StatelessWidget {
   SCNumberKeyboardItem({
     Key? key,
     this.numberTapAction,
     this.deleteAction,
   }) : super(key: key);
   /// 数字键盘点击
   final Function(int value)? numberTapAction;
   /// 点击删除
   final Function? deleteAction;

  final numberList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 0];
  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      color: SCColors.color_E3E3E5,
      child: gridView(),
    );
  }

  /// gridView
  Widget gridView() {
    return StaggeredGridView.countBuilder(
        padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0, bottom: 0.0),
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        crossAxisCount: 3,
        shrinkWrap: true,
        itemCount: 12,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return numberCellItem(index);
        },
        staggeredTileBuilder: (int index) {
          return const StaggeredTile.fit(1);
        });

  }

  /// 数字键盘按钮
  Widget numberCellItem(int index) {
    if (index == 11) {
      return CupertinoButton(
        color: SCColors.color_EDEDF0,
        borderRadius: BorderRadius.circular(5.0),
        padding: EdgeInsets.zero,
        child: Image.asset(
          SCAsset.iconLoginNumberDelete,
          width: 24.0,
          height: 24.0,
        ),
        onPressed: () {
          if (deleteAction != null) {
            deleteAction?.call();
          }
        });
    } else {
      return CupertinoButton(
        color: SCColors.color_FFFFFF,
        borderRadius: BorderRadius.circular(5.0),
        padding: EdgeInsets.zero,
        child: Text(
          index == 9 ? 'X' : '${numberList[index]}',
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: SCFonts.f24,
            fontWeight: FontWeight.w400,
            color: SCColors.color_1B1D33,
          ),
        ),
        onPressed: () {
          if (index != 9 && numberTapAction != null) {
            numberTapAction?.call(numberList[index]);
          }
        }
      );
    }
  }
}
