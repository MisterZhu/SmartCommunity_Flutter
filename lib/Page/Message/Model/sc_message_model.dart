class SCMessageModel {
  SCMessageModel({
      this.content, 
      this.creator, 
      this.creatorName, 
      this.deleted, 
      this.gmtCreate, 
      this.iconUrl, 
      this.id, 
      this.isRead, 
      this.jumpUrl, 
      this.state, 
      this.subTitle, 
      this.tenantId, 
      this.title, 
      this.typeId, 
      this.typeName, 
      this.userIds,});

  SCMessageModel.fromJson(dynamic json) {
    content = json['content'];
    creator = json['creator'];
    creatorName = json['creatorName'];
    deleted = json['deleted'];
    gmtCreate = json['gmtCreate'];
    iconUrl = json['iconUrl'];
    id = json['id'];
    isRead = json['isRead'];
    jumpUrl = json['jumpUrl'];
    state = json['state'];
    subTitle = json['subTitle'];
    tenantId = json['tenantId'];
    title = json['title'];
    typeId = json['typeId'];
    typeName = json['typeName'];
    userIds = json['userIds'];
  }
  String? content;
  String? creator;
  String? creatorName;
  int? deleted;
  String? gmtCreate;
  String? iconUrl;
  String? id;
  int? isRead;
  String? jumpUrl;
  String? state;
  String? subTitle;
  String? tenantId;
  String? title;
  String? typeId;
  String? typeName;
  String? userIds;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['content'] = content;
    map['creator'] = creator;
    map['creatorName'] = creatorName;
    map['deleted'] = deleted;
    map['gmtCreate'] = gmtCreate;
    map['iconUrl'] = iconUrl;
    map['id'] = id;
    map['isRead'] = isRead;
    map['jumpUrl'] = jumpUrl;
    map['state'] = state;
    map['subTitle'] = subTitle;
    map['tenantId'] = tenantId;
    map['title'] = title;
    map['typeId'] = typeId;
    map['typeName'] = typeName;
    map['userIds'] = userIds;
    return map;
  }

}