import 'package:flutter/material.dart';

/// Copyright (c), 浙江慧享信息科技有限公司
/// FileName: demo_sc_house_room_model
/// Author: wang tao
/// Email: wangtao1@lvchengfuwu.com
/// Date: 2022/8/17 14:13
/// Description: 选择房号 -- 房间层级

class DemoSCHouseRoomModel {

  String id;
  String? name;
  bool? isChecked;

  DemoSCHouseRoomModel({
    required this.id,
    this.name,
    this.isChecked,
  });

  DemoSCHouseRoomModel.fromJson(Map<String, dynamic> json) : id = json['id'];

  Map<String, dynamic> toJson() => {
    'id': id,
  };

  @override
  String toString() {
    return 'DemoSCHouseRoomModel{id: $id, name: $name}';
  }
}
