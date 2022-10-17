import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartcommunity/constants/sc_colors.dart';

/// picker-自定义header
class SCPickerHeader extends StatelessWidget {
  const SCPickerHeader(
      {Key? key,
      this.title = '请选择',
      this.cancelText = '取消',
      this.sureText = '确定',
      this.cancelTap,
      this.sureTap})
      : super(key: key);

  /// 标题
  final String? title;

  /// 取消文本
  final String? cancelText;

  /// 确定文本
  final String? sureText;

  /// 点击取消按钮
  final Function? cancelTap;

  /// 点击确定按钮
  final Function? sureTap;

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    String titleString = title ?? '请选择';
    String cancelString = cancelText ?? '取消';
    String sureString = sureText ?? '确定';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      height: 44.0,
      color: SCColors.color_F7F8FA,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CupertinoButton(
              padding: EdgeInsets.zero,
              child: Text(
                cancelString,
                style: const TextStyle(
                    fontSize: 16.0, color: SCColors.color_FF571A),
              ),
              onPressed: () {
                cancelTap?.call();
              }),
          Expanded(
              child: Text(
            titleString,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style:
                const TextStyle(fontSize: 12.0, color: SCColors.color_5E5F66),
          )),
          CupertinoButton(
              padding: EdgeInsets.zero,
              child: Text(
                sureString,
                style: const TextStyle(
                    fontSize: 16.0, color: SCColors.color_FF571A),
              ),
              onPressed: () {
                sureTap?.call();
              })
        ],
      ),
    );
  }
}
