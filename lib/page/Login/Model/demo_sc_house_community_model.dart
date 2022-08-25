import 'package:flutter/material.dart';

/// Copyright (c), 浙江慧享信息科技有限公司
/// FileName: demo_sc_house_community_model
/// Author: wang tao
/// Email: wangtao1@lvchengfuwu.com
/// Date: 2022/8/17 14:13
/// Description: 选择房号 -- 苑层级

class DemoSCHouseCommunityModel {

  String id;
  String? name;
  bool? isChecked;

  DemoSCHouseCommunityModel({
    required this.id,
    this.name,
    this.isChecked,
  });

  DemoSCHouseCommunityModel.fromJson(Map<String, dynamic> json) : id = json['id'];

  Map<String, dynamic> toJson() => {
    'id': id,
  };

  @override
  String toString() {
    return 'DemoSCHouseCommunityModel{id: $id, name: $name}';
  }
}
