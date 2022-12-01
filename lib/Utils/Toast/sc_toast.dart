import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// toast工具类

class SCToast {
  static void showTip(String msg) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER
    );
  }

  /// 自定义tip位置
  static void showTipWithGravity({String? msg, ToastGravity? gravity}) {
    String message = msg ?? '';
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: gravity
    );
  }
}