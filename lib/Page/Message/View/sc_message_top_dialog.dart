
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../../Constants/sc_asset.dart';

/// 消息-更多弹窗

class SCMessageTopDialog extends StatelessWidget{

  final List list;
  /// 点击
  final Function(int index)? tapAction;

  /// 点击空白位置关闭弹窗
  final Function? closeAction;

  SCMessageTopDialog({Key? key, required this.list, this.tapAction, this.closeAction}) : super(key: key);

  /// cell高度
  double cellHeight = 46.0;

  /// cell宽度108
  double cellWidth = 108.0;

  /// 弹窗宽度120
  double width = 108.0 + 12;

  /// 顶部offset28.0
  double topOffSet = 28.0;

  /// 三角形高度6.0
  double triangleHeight = 6.0;

  /// 上下阴影8.0
  double shadowOffSet = 8.0;

  /// 最多数量
  int maxCount = 6;

  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    double viewHeight = list.length > maxCount ? cellHeight * maxCount + shadowOffSet * 2 + triangleHeight : cellHeight * list.length + shadowOffSet * 2 + triangleHeight;
    return Stack(
      children: [
        Positioned(
          left: 0.0,
          right: 0.0,
          top: 0.0,
          bottom: 0.0,
          child: GestureDetector(
            onTap: () {
              closeAction?.call();
            },
            child: Container(color: Colors.transparent,),
          )),
        Positioned(
          top: topOffSet,
          right: 2.0,
          width: width,
          height: viewHeight,
          child: contentView(viewHeight))
      ],
    );
  }

  /// 弹窗view
  Widget contentView(double height) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.asset(
          SCAsset.iconMessageMoreBg,
          centerSlice: const Rect.fromLTRB(24, 23, 86, 95),
          width: width,
          height: height,
        ),
        listview(),
      ],
    );
  }

  Widget listview() {
    ScrollPhysics physics = list.length > maxCount ? const ClampingScrollPhysics() : const NeverScrollableScrollPhysics();
    double height = list.length > maxCount ? cellHeight * maxCount + shadowOffSet : cellHeight * list.length + shadowOffSet;
    return Container(
        width: cellWidth,
        height: height,
        padding: EdgeInsets.only(bottom: shadowOffSet),
        child: ListView.separated(
            padding: const EdgeInsets.only(left: 12.0),
            shrinkWrap: true,
            physics: physics,
            itemBuilder: (BuildContext context, int index) {
              return cell(index);
            },
            separatorBuilder: (BuildContext context, int index) {
              return Container(height: 0.5, color: SCColors.color_EDEDF0,);
            },
            itemCount: list.length));
  }

  Widget cell(int index) {
    return GestureDetector(
      onTap: () {
        tapAction?.call(index);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: cellHeight,
        alignment: Alignment.centerLeft,
        child: Text(
          list[index],
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: SCFonts.f14,
            color: SCColors.color_1B1D33,
            fontWeight: FontWeight.w400,
          ),),
      ),
    );
  }
}