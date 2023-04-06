/// 消息卡片model

class SCMessageCardModel {
  SCMessageCardModel({
      this.noticeCardType,   // 卡片类型 1:数据卡片形式; 2:文章消息卡片 ,可用值:1,2
      this.noticeArriveId, 
      this.jumpDetail,     // 跳转详情 true 跳转 false 不跳转
      this.title, 
      this.cardCode, 
      this.icon, 
      this.linkImage, 
      this.category, 
      this.modelCode, 
      this.modelCodeName, 
      this.content, 
      this.displayItems, 
      this.noticeTime,});

  SCMessageCardModel.fromJson(dynamic json) {
    noticeCardType = json['noticeCardType'];
    noticeArriveId = json['noticeArriveId'];
    jumpDetail = json['jumpDetail'];
    title = json['title'];
    cardCode = json['cardCode'];
    icon = json['icon'] != null ? Icon.fromJson(json['icon']) : null;
    linkImage = json['linkImage'];
    category = json['category'];
    modelCode = json['modelCode'];
    modelCodeName = json['modelCodeName'];
    content = json['content'];
    if (json['displayItems'] != null) {
      displayItems = [];
      json['displayItems'].forEach((v) {
        displayItems?.add(DisplayItems.fromJson(v));
      });
    }
    noticeTime = json['noticeTime'];
  }
  int? noticeCardType;
  int? noticeArriveId;
  bool? jumpDetail;
  String? title;
  int? cardCode;
  Icon? icon;
  String? linkImage;
  String? category;
  String? modelCode;
  String? modelCodeName;
  String? content;
  List<DisplayItems>? displayItems;
  String? noticeTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['noticeCardType'] = noticeCardType;
    map['noticeArriveId'] = noticeArriveId;
    map['jumpDetail'] = jumpDetail;
    map['title'] = title;
    map['cardCode'] = cardCode;
    if (icon != null) {
      map['icon'] = icon?.toJson();
    }
    map['linkImage'] = linkImage;
    map['category'] = category;
    map['modelCode'] = modelCode;
    map['modelCodeName'] = modelCodeName;
    map['content'] = content;
    if (displayItems != null) {
      map['displayItems'] = displayItems?.map((v) => v.toJson()).toList();
    }
    map['noticeTime'] = noticeTime;
    return map;
  }

}

class DisplayItems {
  DisplayItems({
      this.head, 
      this.content, 
      this.noticeConsumerMobileCardItemDisplayType,});

  DisplayItems.fromJson(dynamic json) {
    head = json['head'];
    content = json['content'];
    noticeConsumerMobileCardItemDisplayType = json['noticeConsumerMobileCardItemDisplayType'];
  }
  String? head;
  String? content;
  int? noticeConsumerMobileCardItemDisplayType;  // 1值换行+加粗，2头+尾

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['head'] = head;
    map['content'] = content;
    map['noticeConsumerMobileCardItemDisplayType'] = noticeConsumerMobileCardItemDisplayType;
    return map;
  }

}

class Icon {
  Icon({
      this.fileKey, 
      this.name, 
      this.suffix, 
      this.size, 
      this.type,});

  Icon.fromJson(dynamic json) {
    fileKey = json['fileKey'];
    name = json['name'];
    suffix = json['suffix'];
    size = json['size'];
    type = json['type'];
  }
  String? fileKey;
  String? name;
  String? suffix;
  String? size;
  int? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fileKey'] = fileKey;
    map['name'] = name;
    map['suffix'] = suffix;
    map['size'] = size;
    map['type'] = type;
    return map;
  }

}