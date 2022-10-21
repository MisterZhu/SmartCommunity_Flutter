import 'package:flutter/services.dart';
/// 输入框formatter
class SCInputFormatter extends TextInputFormatter {

  /// 正则表达式
  final RegExp regExp;

  SCInputFormatter(this.regExp);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty) {
      if (regExp.firstMatch(newValue.text) != null) {
        return newValue;
      }
      return oldValue;
    }
    return newValue;
  }
}