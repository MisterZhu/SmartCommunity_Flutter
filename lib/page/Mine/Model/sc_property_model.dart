// To parse this JSON data, do
// 我的-我的资产-model
// final scPropertyModel = scPropertyModelFromJson(jsonString);

import 'dart:convert';

SCPropertyModel scPropertyModelFromJson(String str) => SCPropertyModel.fromJson(json.decode(str));

String scPropertyModelToJson(SCPropertyModel data) => json.encode(data.toJson());

class SCPropertyModel {
  SCPropertyModel({
    this.title,
    this.data,
  });

  /// 标题
  String? title;
  /// 数据源
  List<SCPropertyTypeModel>? data;

  factory SCPropertyModel.fromJson(Map<String, dynamic> json) => SCPropertyModel(
    title: json["title"],
    data: List<SCPropertyTypeModel>.from(json["data"].map((x) => SCPropertyTypeModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SCPropertyTypeModel {
  SCPropertyTypeModel({
    this.type,
    this.title,
    this.plateNumberDes,
    this.plateNumber,
    this.brandDes,
    this.brand,
    this.colorDes,
    this.color,
    this.data,
  });
  /// 资产类型 0-车辆 1-车位 2-库房
  int? type;
  /// 资产类型-title
  String? title;
  /// 车牌-title
  String? plateNumberDes;
  /// 车牌号
  String? plateNumber;
  /// 品牌-title
  String? brandDes;
  /// 品牌
  String? brand;
  /// 颜色-title
  String? colorDes;
  /// 颜色
  String? color;
  /// 数据
  List<String>? data;

  factory SCPropertyTypeModel.fromJson(Map<String, dynamic> json) => SCPropertyTypeModel(
    type: json["type"],
    title: json["title"],
    plateNumberDes: json["plateNumberDes"],
    plateNumber: json["plateNumber"],
    brandDes: json["brandDes"],
    brand: json["brand"],
    colorDes: json["colorDes"],
    color: json["color"],
    data: List<String>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "title": title,
    "plateNumberDes": plateNumberDes,
    "plateNumber": plateNumber,
    "brandDes": brandDes,
    "brand": brand,
    "colorDes": colorDes,
    "color": color,
    "data": List<dynamic>.from(data!.map((x) => x)),
  };
}
