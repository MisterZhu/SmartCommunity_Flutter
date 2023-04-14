/// 消息卡片model

class SCMessageCardModel {
  SCMessageCardModel({
    this.cardCode,
    this.category,
    this.content,
    this.creator,
    this.creatorName,
    this.displayItems,
    this.ext,
    this.gmtCreate,
    this.icon,
    this.linkImage,
    this.modelCode,
    this.modelCodeName,
    this.noticeArriveId,
    this.noticeCardType,
    this.noticeCardTypeName,
    this.noticeId,
    this.noticeTime,
    this.title,});

  SCMessageCardModel.fromJson(dynamic json) {
    cardCode = json['cardCode'];
    category = json['category'];
    content = json['content'];
    creator = json['creator'];
    creatorName = json['creatorName'];
    if (json['displayItems'] != null) {
      displayItems = [];
      json['displayItems'].forEach((v) {
        displayItems?.add(DisplayItems.fromJson(v));
      });
    }
    ext = json['ext'];
    gmtCreate = json['gmtCreate'];
    icon = json['icon'] != null ? Icon.fromJson(json['icon']) : null;
    linkImage = json['linkImage'] != null ? Icon.fromJson(json['linkImage']) : null;
    modelCode = json['modelCode'];
    modelCodeName = json['modelCodeName'];
    noticeArriveId = json['noticeArriveId'];
    noticeCardType = json['noticeCardType'];
    noticeCardTypeName = json['noticeCardTypeName'];
    noticeId = json['noticeId'];
    noticeTime = json['noticeTime'];
    title = json['title'];
  }
  String? cardCode;
  String? category;
  String? content;
  String? creator;
  String? creatorName;
  List<DisplayItems>? displayItems;
  String? ext;
  String? gmtCreate;
  Icon? icon;
  Icon? linkImage;
  String? modelCode;
  String? modelCodeName;
  int? noticeArriveId;
  int? noticeCardType;
  String? noticeCardTypeName;
  String? noticeId;
  String? noticeTime;
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cardCode'] = cardCode;
    map['category'] = category;
    map['content'] = content;
    map['creator'] = creator;
    map['creatorName'] = creatorName;
    if (displayItems != null) {
      map['displayItems'] = displayItems?.map((v) => v.toJson()).toList();
    }
    map['ext'] = ext;
    map['gmtCreate'] = gmtCreate;
    if (icon != null) {
      map['icon'] = icon?.toJson();
    }
    if (linkImage != null) {
      map['linkImage'] = linkImage?.toJson();
    }
    map['modelCode'] = modelCode;
    map['modelCodeName'] = modelCodeName;
    map['noticeArriveId'] = noticeArriveId;
    map['noticeCardType'] = noticeCardType;
    map['noticeCardTypeName'] = noticeCardTypeName;
    map['noticeId'] = noticeId;
    map['noticeTime'] = noticeTime;
    map['title'] = title;
    return map;
  }

}

class Icon {
  Icon({
    this.fileKey,
    this.name,
    this.size,
    this.suffix,
    this.type,});

  Icon.fromJson(dynamic json) {
    fileKey = json['fileKey'];
    name = json['name'];
    size = json['size'];
    suffix = json['suffix'];
    type = json['type'];
  }
  String? fileKey;
  String? name;
  int? size;
  String? suffix;
  int? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fileKey'] = fileKey;
    map['name'] = name;
    map['size'] = size;
    map['suffix'] = suffix;
    map['type'] = type;
    return map;
  }

}

class DisplayItems {
  DisplayItems({
    this.content,
    this.head,
    this.noticeConsumerMobileCardItemDisplayType,});

  DisplayItems.fromJson(dynamic json) {
    content = json['content'];
    head = json['head'];
    noticeConsumerMobileCardItemDisplayType = json['noticeConsumerMobileCardItemDisplayType'];
  }
  String? content;
  String? head;
  int? noticeConsumerMobileCardItemDisplayType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['content'] = content;
    map['head'] = head;
    map['noticeConsumerMobileCardItemDisplayType'] = noticeConsumerMobileCardItemDisplayType;
    return map;
  }

}