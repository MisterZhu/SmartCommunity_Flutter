import 'package:flutter/material.dart';

/// Copyright (c), 浙江慧享信息科技有限公司
/// FileName: demo_sc_house_building_model
/// Author: wang tao
/// Email: wangtao1@lvchengfuwu.com
/// Date: 2022/8/17 14:13
/// Description: 选择房号 -- 幢层级

class DemoSCHouseBuildingModel {

  String id;
  String? name;
  bool? isChecked;

  DemoSCHouseBuildingModel({
    required this.id,
    this.name,
    this.isChecked,
  });

  DemoSCHouseBuildingModel.fromJson(Map<String, dynamic> json) : id = json['id'];

  Map<String, dynamic> toJson() => {
    'id': id,
  };

  @override
  String toString() {
    return 'DemoSCHouseBuildingModel{id: $id, name: $name}';
  }
}
