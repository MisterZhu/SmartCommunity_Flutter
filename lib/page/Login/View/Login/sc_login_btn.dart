import 'package:flutter/cupertino.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/utils/sc_utils.dart';

/// 登录按钮

class SCLoginBtn extends StatelessWidget {

  const SCLoginBtn({Key? key, this.onPressed, this.enable = false}) : super(key: key);

  final Function? onPressed;

  /// 是否可以点击
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  /// body
  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 44.0,
        decoration: BoxDecoration(
            color: enable == true ? SCColors.color_FF6C00 : SCColors.color_FFC59B,
            borderRadius: BorderRadius.circular(4.0)),
        child: CupertinoButton(
            padding: EdgeInsets.zero,
            child: const Text(
              '登录',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                color: SCColors.color_FFFFFF,
              ),
            ),
            onPressed: () {
              SCUtils().hideKeyboard(context: context);
              if (onPressed != null) {
                onPressed?.call();
              }
            }),
      ),
    );
  }
}
