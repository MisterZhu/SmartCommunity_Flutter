/// 首页-资讯model

// To parse this JSON data, do
//
//     final scHomeNewsModel = scHomeNewsModelFromJson(jsonString);

import 'dart:convert';

SCHomeNewsModel scHomeNewsModelFromJson(String str) => SCHomeNewsModel.fromJson(json.decode(str));

String scHomeNewsModelToJson(SCHomeNewsModel data) => json.encode(data.toJson());

class SCHomeNewsModel {
  var frontCover;

  SCHomeNewsModel({
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

  factory SCHomeNewsModel.fromJson(Map<String, dynamic> json) => SCHomeNewsModel(
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
