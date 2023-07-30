import 'dart:convert';

class SCHomePromotionModel {
  int? id;
  String? title;
  List<PromotionLocation>? location;
  int? jumpType;
  int? sort;
  int? state;
  String? stateName;
  String? gmtOnline;
  String? gmtOffline;
  String? operator;
  String? operatorName;
  String? gmtModify;
  List<PromotionPictures>? pictures;
  String? detail;
  String? gmtCreate;
  int? isFixedOnline;
  int? isFixedOffline;
  String? target;
  List<SCTargetObj>? targetObj;
  String? pictureRatio;

  SCHomePromotionModel(
      {this.id,
      this.title,
      this.location,
      this.jumpType,
      this.sort,
      this.state,
      this.stateName,
      this.gmtOnline,
      this.gmtOffline,
      this.operator,
      this.operatorName,
      this.gmtModify,
      this.pictures,
      this.detail,
      this.gmtCreate,
      this.isFixedOnline,
      this.isFixedOffline,
      this.target,
      this.targetObj,
      this.pictureRatio});

  SCHomePromotionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    if (json['location'] != null) {
      location = <PromotionLocation>[];
      json['location'].forEach((v) {
        location!.add(new PromotionLocation.fromJson(v));
      });
    }
    jumpType = json['jumpType'];
    sort = json['sort'];
    state = json['state'];
    stateName = json['stateName'];
    gmtOnline = json['gmtOnline'];
    gmtOffline = json['gmtOffline'];
    operator = json['operator'];
    operatorName = json['operatorName'];
    gmtModify = json['gmtModify'];
    if (json['pictures'] != null) {
      pictures = <PromotionPictures>[];
      json['pictures'].forEach((v) {
        pictures!.add(PromotionPictures.fromJson(v));
      });
    }
    detail = json['detail'];
    gmtCreate = json['gmtCreate'];
    isFixedOnline = json['isFixedOnline'];
    isFixedOffline = json['isFixedOffline'];
    target = json['target'];
    if (json['targetObj'] != null) {
      targetObj = <SCTargetObj>[];
      json['targetObj'].forEach((v) {
        targetObj!.add(SCTargetObj.fromJson(v));
      });
    }
    pictureRatio = json['pictureRatio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.location != null) {
      data['location'] = this.location!.map((v) => v.toJson()).toList();
    }
    data['jumpType'] = this.jumpType;
    data['sort'] = this.sort;
    data['state'] = this.state;
    data['stateName'] = this.stateName;
    data['gmtOnline'] = this.gmtOnline;
    data['gmtOffline'] = this.gmtOffline;
    data['operator'] = this.operator;
    data['operatorName'] = this.operatorName;
    data['gmtModify'] = this.gmtModify;
    if (this.pictures != null) {
      data['pictures'] = this.pictures!.map((v) => v.toJson()).toList();
    }
    data['detail'] = this.detail;
    data['gmtCreate'] = this.gmtCreate;
    data['isFixedOnline'] = this.isFixedOnline;
    data['isFixedOffline'] = this.isFixedOffline;
    data['target'] = this.target;
    data['targetObj'] = this.targetObj;
    data['pictureRatio'] = this.pictureRatio;
    return data;
  }
}
class SCTargetObj {
  String? label;
  String? value;

  SCTargetObj({this.label, this.value});

  SCTargetObj.fromJson(Map<String, dynamic> json) {
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
class PromotionLocation {
  String? label;
  int? value;

  PromotionLocation({this.label, this.value});

  PromotionLocation.fromJson(Map<String, dynamic> json) {
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

class PromotionPictures {
  int? size;
  String? name;
  String? fileKey;
  int? type;
  String? suffix;

  PromotionPictures({this.size, this.name, this.fileKey, this.type, this.suffix});

  PromotionPictures.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    name = json['name'];
    fileKey = json['fileKey'];
    type = json['type'];
    suffix = json['suffix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size'] = this.size;
    data['name'] = this.name;
    data['fileKey'] = this.fileKey;
    data['type'] = this.type;
    data['suffix'] = this.suffix;
    return data;
  }
}