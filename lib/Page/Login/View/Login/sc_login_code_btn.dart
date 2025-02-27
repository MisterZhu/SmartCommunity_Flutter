import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';

/// 获取验证码按钮

class SCLoginCodeBtn extends StatelessWidget {

  const SCLoginCodeBtn({Key? key, this.onPressed, this.enable = false}) : super(key: key);

  /// 按钮点击
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
      padding: const EdgeInsets.symmetric(horizontal: 57.0),
      child: SizedBox(
        width: double.infinity,
        height: 48.0,
        child: CupertinoButton(
            padding: EdgeInsets.zero,
            color: enable == true ? SCColors.color_1B1D33 : SCColors.color_B0B1B8,
            borderRadius: BorderRadius.circular(8.0),
            child: const Text(
              '获取验证码',
              style: TextStyle(
                fontSize: SCFonts.f16,
                fontWeight: FontWeight.w500,
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
