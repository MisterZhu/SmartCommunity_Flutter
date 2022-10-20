import 'package:date_format/date_format.dart';

/// locale

class SCDateLocale implements DateLocale {
  const SCDateLocale();

  @override
  final List<String> monthsShort = const [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12'
  ];

  @override
  final List<String> monthsLong = const [
    '一月',
    '二月',
    '三月',
    '四月',
    '五月',
    '六月',
    '七月',
    '八月',
    '九月',
    '十月',
    '十一月',
    '十二月'
  ];

  @override
  final List<String> daysShort = const [
    '周一',
    '周二',
    '周三',
    '周四',
    '周五',
    '周六',
    '周日'
  ];

  @override
  final List<String> daysLong = const [
    '星期一',
    '星期二',
    '星期三',
    '星期四',
    '星期五',
    '星期六',
    '星期日'
  ];

  @override
  String get am => "上午";

  @override
  String get pm => "下午";
}