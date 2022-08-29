import 'package:flutter/material.dart';

/// Copyright (c), 浙江慧享信息科技有限公司
/// FileName: demo_sc_house_unit_model
/// Author: wang tao
/// Email: wangtao1@lvchengfuwu.com
/// Date: 2022/8/17 14:13
/// Description: 选择房号 -- 单元层级

class DemoSCHouseUnitModel {

  String id;
  String? name;
  bool? isChecked;

  DemoSCHouseUnitModel({
    required this.id,
    this.name,
    this.isChecked,
  });

  DemoSCHouseUnitModel.fromJson(Map<String, dynamic> json) : id = json['id'];

  Map<String, dynamic> toJson() => {
    'id': id,
  };

  @override
  String toString() {
    return 'DemoSCHouseUnitModel{id: $id, name: $name}';
  }
}
