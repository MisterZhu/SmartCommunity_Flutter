
import 'package:flutter/cupertino.dart';
import '../../../../Constants/sc_colors.dart';
import '../../../../Constants/sc_fonts.dart';
import '../../../../Utils/sc_utils.dart';

/// 游客模式、邀请码注册按钮
class SCLoginBtnItem extends StatelessWidget {

  const SCLoginBtnItem({Key? key, this.skipTapAction, this.register}) : super(key: key);

  final Function? skipTapAction;

  final Function? register;

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  /// body
  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 57.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CupertinoButton(
            padding: const EdgeInsets.only(left: 0.0, top: 4.0, right: 5.0, bottom: 4.0),
            child: const Text(
              '游客模式',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: SCFonts.f12,
                fontWeight: FontWeight.w400,
                color: SCColors.color_5E5F66,
              ),
            ),
            onPressed: () {
              SCUtils().hideKeyboard(context: context);
              if (skipTapAction != null) {
                skipTapAction?.call();
              }
            }),
          CupertinoButton(
              padding: const EdgeInsets.only(left: 5.0, top: 4.0, right: 0.0, bottom: 4.0),
              child: const Text(
                '邀请码注册',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: SCFonts.f12,
                  fontWeight: FontWeight.w400,
                  color: SCColors.color_5E5F66,
                ),
              ),
              onPressed: () {
                SCUtils().hideKeyboard(context: context);
                if (register != null) {
                  register?.call();
                }
              })
        ],
      ),
    );
  }
}
