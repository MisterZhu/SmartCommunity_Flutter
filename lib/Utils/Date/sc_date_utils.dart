import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:smartcommunity/Utils/Date/sc_date_locale.dart';

/// 日期工具

class SCDateUtils {

  /// 日期转指定类型的日期字符串：formatDateWithString('2022-01-01', ['yyyy', '-', 'mm', '-', 'dd'])
  static String transformDate({required DateTime dateTime, required List<String> formats, DateLocale? locale}) {
    return formatDate(dateTime, formats, locale: locale ?? const SCDateLocale());
  }

  /// 时间戳
  static int timestamp() {
    return DateTime.now().millisecondsSinceEpoch;
  }
}