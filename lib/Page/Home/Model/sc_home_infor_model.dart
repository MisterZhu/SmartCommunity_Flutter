/// 首页-资讯model

// To parse this JSON data, do
//
//     final scHomeInforModel = scHomeInforModelFromJson(jsonString);

import 'dart:convert';

class SCHomeInforModel {
  int? id;
  String? title;
  String? outline;
  int? categoryId;
  int? isFixedTime;
  String? categoryName;
  String? gmtPublish;
  String? target;
  int? state;
  int? sort;
  String? creator;
  String? creatorName;
  String? gmtCreate;
  String? operator;
  String? operatorName;
  String? gmtModify;
  String? tags;
  String? tenantId;
  Detail? detail;
  SCFrontCover? frontCover;
  String? showEffect;
  String? imgList;
  List<TargetObj>? targetObj;

  SCHomeInforModel(
      {this.id,
      this.title,
      this.outline,
      this.categoryId,
      this.isFixedTime,
      this.categoryName,
      this.gmtPublish,
      this.target,
      this.state,
      this.sort,
      this.creator,
      this.creatorName,
      this.gmtCreate,
      this.operator,
      this.operatorName,
      this.gmtModify,
      this.tags,
      this.tenantId,
      this.detail,
      this.frontCover,
      this.showEffect,
      this.imgList,
      this.targetObj});

  SCHomeInforModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    outline = json['outline'];
    categoryId = json['categoryId'];
    isFixedTime = json['isFixedTime'];
    categoryName = json['categoryName'];
    gmtPublish = json['gmtPublish'];
    target = json['target'];
    state = json['state'];
    sort = json['sort'];
    creator = json['creator'];
    creatorName = json['creatorName'];
    gmtCreate = json['gmtCreate'];
    operator = json['operator'];
    operatorName = json['operatorName'];
    gmtModify = json['gmtModify'];
    tags = json['tags'];
    tenantId = json['tenantId'];
    detail =
        json['detail'] != null ? Detail.fromJson(json['detail']) : null;
    frontCover = json['frontCover'] != null ? SCFrontCover.fromJson(json['frontCover']) : null;
    showEffect = json['showEffect'];
    imgList = json['imgList'];
    if (json['targetObj'] != null) {
      targetObj = <TargetObj>[];
      json['targetObj'].forEach((v) {
        targetObj!.add(new TargetObj.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['outline'] = this.outline;
    data['categoryId'] = this.categoryId;
    data['isFixedTime'] = this.isFixedTime;
    data['categoryName'] = this.categoryName;
    data['gmtPublish'] = this.gmtPublish;
    data['target'] = this.target;
    data['state'] = this.state;
    data['sort'] = this.sort;
    data['creator'] = this.creator;
    data['creatorName'] = this.creatorName;
    data['gmtCreate'] = this.gmtCreate;
    data['operator'] = this.operator;
    data['operatorName'] = this.operatorName;
    data['gmtModify'] = this.gmtModify;
    data['tags'] = this.tags;
    data['tenantId'] = this.tenantId;
    if (this.detail != null) {
      data['detail'] = this.detail!.toJson();
    }
    data['frontCover'] = this.frontCover;
    data['showEffect'] = this.showEffect;
    data['imgList'] = this.imgList;
    if (this.targetObj != null) {
      data['targetObj'] = this.targetObj!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Detail {
  String? note;

  Detail({this.note});

  Detail.fromJson(Map<String, dynamic> json) {
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['note'] = this.note;
    return data;
  }
}
class SCFrontCover {
  String? fileKey;

  SCFrontCover({this.fileKey});

  SCFrontCover.fromJson(Map<String, dynamic> json) {
    fileKey = json['fileKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileKey'] = this.fileKey;
    return data;
  }
}
class TargetObj {
  String? label;
  String? value;

  TargetObj({this.label, this.value});

  TargetObj.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['value'] = this.value;
    return data;
  }
}