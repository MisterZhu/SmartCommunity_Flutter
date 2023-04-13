
/// 优惠券model

class SCCouponModel {
  SCCouponModel({
      this.andLimit, 
      this.category, 
      this.categoryName, 
      this.channel, 
      this.code, 
      this.creator, 
      this.creatorName, 
      this.deductAmount, 
      this.deleted, 
      this.gainWays, 
      this.gainWaysName, 
      this.gmtCreate, 
      this.gmtEffect, 
      this.gmtExpire, 
      this.gmtModify, 
      this.gmtRefund, 
      this.gmtUsed, 
      this.id, 
      this.instructions, 
      this.issueType, 
      this.issueTypeName, 
      this.issuer, 
      this.issuerName, 
      this.mobileNum, 
      this.operator, 
      this.operatorName, 
      this.orderAmount, 
      this.orderId, 
      this.organizer, 
      this.organizerName, 
      this.refund, 
      this.refundAmount, 
      this.state, 
      this.stateName, 
      this.subTitle, 
      this.suitApplicationName, 
      this.suitClient, 
      this.suitClientName, 
      this.suitScope, 
      this.suitScopeDesc, 
      this.suitSellerName, 
      this.suitStore, 
      this.tenantId, 
      this.thresholdAmount, 
      this.title, 
      this.toUseLink, 
      this.userId, 
      this.userName, 
      this.voucherId, 
      this.voucherStateName,});

  SCCouponModel.fromJson(dynamic json) {
    andLimit = json['andLimit'];
    category = json['category'];
    categoryName = json['categoryName'];
    channel = json['channel'];
    code = json['code'];
    creator = json['creator'];
    creatorName = json['creatorName'];
    deductAmount = json['deductAmount'];
    deleted = json['deleted'];
    gainWays = json['gainWays'];
    gainWaysName = json['gainWaysName'];
    gmtCreate = json['gmtCreate'];
    gmtEffect = json['gmtEffect'];
    gmtExpire = json['gmtExpire'];
    gmtModify = json['gmtModify'];
    gmtRefund = json['gmtRefund'];
    gmtUsed = json['gmtUsed'];
    id = json['id'];
    instructions = json['instructions'];
    issueType = json['issueType'];
    issueTypeName = json['issueTypeName'];
    issuer = json['issuer'];
    issuerName = json['issuerName'];
    mobileNum = json['mobileNum'];
    operator = json['operator'];
    operatorName = json['operatorName'];
    orderAmount = json['orderAmount'];
    orderId = json['orderId'];
    organizer = json['organizer'];
    organizerName = json['organizerName'];
    refund = json['refund'];
    refundAmount = json['refundAmount'];
    state = json['state'];
    stateName = json['stateName'];
    subTitle = json['subTitle'];
    suitApplicationName = json['suitApplicationName'];
    suitClient = json['suitClient'];
    suitClientName = json['suitClientName'];
    if (json['suitScope'] != null) {
      suitScope = [];
      json['suitScope'].forEach((v) {
        suitScope?.add(SuitScope.fromJson(v));
      });
    }
    suitScopeDesc = json['suitScopeDesc'];
    suitSellerName = json['suitSellerName'] != null ? json['suitSellerName'].cast<String>() : [];
    suitStore = json['suitStore'] != null ? SuitStore.fromJson(json['suitStore']) : null;
    tenantId = json['tenantId'];
    thresholdAmount = json['thresholdAmount'];
    title = json['title'];
    toUseLink = json['toUseLink'];
    userId = json['userId'];
    userName = json['userName'];
    voucherId = json['voucherId'];
    voucherStateName = json['voucherStateName'];
  }
  int? andLimit;
  int? category;
  String? categoryName;
  String? channel;
  String? code;
  String? creator;
  String? creatorName;
  num? deductAmount;
  bool? deleted;
  int? gainWays;
  String? gainWaysName;
  String? gmtCreate;
  String? gmtEffect;
  String? gmtExpire;
  String? gmtModify;
  String? gmtRefund;
  String? gmtUsed;
  String? id;
  String? instructions;
  int? issueType;
  String? issueTypeName;
  String? issuer;
  String? issuerName;
  String? mobileNum;
  String? operator;
  String? operatorName;
  int? orderAmount;
  String? orderId;
  String? organizer;
  String? organizerName;
  int? refund;
  int? refundAmount;
  int? state;
  String? stateName;
  String? subTitle;
  String? suitApplicationName;
  String? suitClient;
  String? suitClientName;
  List<SuitScope>? suitScope;
  String? suitScopeDesc;
  List<String>? suitSellerName;
  SuitStore? suitStore;
  String? tenantId;
  num? thresholdAmount;
  String? title;
  String? toUseLink;
  String? userId;
  String? userName;
  String? voucherId;
  String? voucherStateName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['andLimit'] = andLimit;
    map['category'] = category;
    map['categoryName'] = categoryName;
    map['channel'] = channel;
    map['code'] = code;
    map['creator'] = creator;
    map['creatorName'] = creatorName;
    map['deductAmount'] = deductAmount;
    map['deleted'] = deleted;
    map['gainWays'] = gainWays;
    map['gainWaysName'] = gainWaysName;
    map['gmtCreate'] = gmtCreate;
    map['gmtEffect'] = gmtEffect;
    map['gmtExpire'] = gmtExpire;
    map['gmtModify'] = gmtModify;
    map['gmtRefund'] = gmtRefund;
    map['gmtUsed'] = gmtUsed;
    map['id'] = id;
    map['instructions'] = instructions;
    map['issueType'] = issueType;
    map['issueTypeName'] = issueTypeName;
    map['issuer'] = issuer;
    map['issuerName'] = issuerName;
    map['mobileNum'] = mobileNum;
    map['operator'] = operator;
    map['operatorName'] = operatorName;
    map['orderAmount'] = orderAmount;
    map['orderId'] = orderId;
    map['organizer'] = organizer;
    map['organizerName'] = organizerName;
    map['refund'] = refund;
    map['refundAmount'] = refundAmount;
    map['state'] = state;
    map['stateName'] = stateName;
    map['subTitle'] = subTitle;
    map['suitApplicationName'] = suitApplicationName;
    map['suitClient'] = suitClient;
    map['suitClientName'] = suitClientName;
    if (suitScope != null) {
      map['suitScope'] = suitScope?.map((v) => v.toJson()).toList();
    }
    map['suitScopeDesc'] = suitScopeDesc;
    map['suitSellerName'] = suitSellerName;
    if (suitStore != null) {
      map['suitStore'] = suitStore?.toJson();
    }
    map['tenantId'] = tenantId;
    map['thresholdAmount'] = thresholdAmount;
    map['title'] = title;
    map['toUseLink'] = toUseLink;
    map['userId'] = userId;
    map['userName'] = userName;
    map['voucherId'] = voucherId;
    map['voucherStateName'] = voucherStateName;
    return map;
  }

}

class SuitStore {
  SuitStore({
      this.label, 
      this.value,});

  SuitStore.fromJson(dynamic json) {
    label = json['label'];
    value = json['value'];
  }
  String? label;
  dynamic value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['label'] = label;
    map['value'] = value;
    return map;
  }

}

class SuitScope {
  SuitScope({
      this.label, 
      this.value,});

  SuitScope.fromJson(dynamic json) {
    label = json['label'];
    value = json['value'];
  }
  String? label;
  dynamic value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['label'] = label;
    map['value'] = value;
    return map;
  }

}