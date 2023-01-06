import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';

/// 退出登录cell

class SCLogOutCell extends StatelessWidget {

  final Function? onTap;

  const SCLogOutCell({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return SizedBox(
      width: double.infinity,
      height: 48.0,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        color: SCColors.color_FFFFFF,
        borderRadius: BorderRadius.circular(0.0),
        child: const Text(
          "退出登录",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: SCFonts.f16,
            fontWeight: FontWeight.w400,
            color: SCColors.color_1B1D33),
          ),
          onPressed: () {
            logout();
          }),
    );
  }

  /// 退出
  logout() {
    if (onTap != null) {
      onTap?.call();
    }
  }
}
