// To parse this JSON data, do
// 我的-我的钱包-model
// final scWalletModel = scWalletModelFromJson(jsonString);

import 'dart:convert';

SCWalletModel scWalletModelFromJson(String str) => SCWalletModel.fromJson(json.decode(str));

String scWalletModelToJson(SCWalletModel data) => json.encode(data.toJson());

class SCWalletModel {
  SCWalletModel({
    this.title,
    this.unit,
    this.type,
    this.subTitle,
  });

  String? title;
  String? unit;
  int? type;
  String? subTitle;

  factory SCWalletModel.fromJson(Map<String, dynamic> json) => SCWalletModel(
    title: json["title"],
    unit: json["unit"],
    type: json["type"],
    subTitle: json["subTitle"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "unit": unit,
    "type": type,
    "subTitle": subTitle,
  };
}
