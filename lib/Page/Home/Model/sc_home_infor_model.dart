/// 首页-资讯model

// To parse this JSON data, do
//
//     final scHomeInforModel = scHomeInforModelFromJson(jsonString);

import 'dart:convert';

SCHomeInforModel scHomeInforModelFromJson(String str) => SCHomeInforModel.fromJson(json.decode(str));

String scHomeInforModelToJson(SCHomeInforModel data) => json.encode(data.toJson());

class SCHomeInforModel {
  SCHomeInforModel({
    this.imageUrl,
    this.title,
    this.date,
    this.likeState,
    this.likeCount,
    this.imageWidth,
    this.imageHeight,
  });

  String? imageUrl;
  String? title;
  String? date;
  bool? likeState;
  int? likeCount;
  double? imageWidth;
  double? imageHeight;

  factory SCHomeInforModel.fromJson(Map<String, dynamic> json) => SCHomeInforModel(
    imageUrl: json["imageUrl"],
    title: json["title"],
    date: json["date"],
    likeState: json["likeState"],
    likeCount: json["likeCount"],
    imageWidth: json["imageWidth"],
    imageHeight: json["imageHeight"],
  );

  Map<String, dynamic> toJson() => {
    "imageUrl": imageUrl,
    "title": title,
    "date": date,
    "likeState": likeState,
    "likeCount": likeCount,
    "imageWidth": imageWidth,
    "imageHeight": imageHeight,
  };
}
