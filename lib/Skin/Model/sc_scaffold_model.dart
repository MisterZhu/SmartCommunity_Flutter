// To parse this JSON data, do
//
//     final mjSkinModel = mjSkinModelFromJson(jsonString);

import 'dart:convert';

SCScaffoldModel scaffoldModelFromJson(String str) => SCScaffoldModel.fromJson(json.decode(str));

String scaffoldModelToJson(SCScaffoldModel data) => json.encode(data.toJson());

class SCScaffoldModel {
  SCScaffoldModel({
    this.skinStyle,
    this.navBackgroundColor,
    this.leadingColor,
    this.trainingColor,
    this.titleColor,
    this.titleFont,
  });

  int? skinStyle;
  String? navBackgroundColor;
  String? leadingColor;
  String? trainingColor;
  String? titleColor;
  double? titleFont;

  factory SCScaffoldModel.fromJson(Map<String, dynamic> json) => SCScaffoldModel(
    skinStyle: json["skinStyle"],
    navBackgroundColor: json["navBackgroundColor"],
    leadingColor: json["leadingColor"],
    trainingColor: json["trainingColor"],
    titleColor: json["titleColor"],
    titleFont: json["titleFont"],
  );

  Map<String, dynamic> toJson() => {
    "skinStyle": skinStyle,
    "navBackgroundColor": navBackgroundColor,
    "leadingColor": leadingColor,
    "trainingColor": trainingColor,
    "titleColor": titleColor,
    "titleFont": titleFont,
  };
}
