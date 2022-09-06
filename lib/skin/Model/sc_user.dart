class SCUser {
  SCUser({
      this.id, 
      this.account, 
      this.userName, 
      this.nickName, 
      this.mobileNum, 
      this.state, 
      this.gender, 
      this.birthday, 
      this.creatorName, 
      this.gmtCreate, 
      this.operatorName, 
      this.gmtModify, 
      this.token,
      this.housingId,
  });

  SCUser.fromJson(dynamic json) {
    id = json['id'];
    account = json['account'];
    userName = json['userName'];
    nickName = json['nickName'];
    mobileNum = json['mobileNum'];
    state = json['state'];
    gender = json['gender'];
    birthday = json['birthday'];
    creatorName = json['creatorName'];
    gmtCreate = json['gmtCreate'];
    operatorName = json['operatorName'];
    gmtModify = json['gmtModify'];
    token = json['token'];
    housingId = json['housingId'];
    communityName = json['communityName'];
  }
  String? id;
  String? account;
  String? userName;
  String? nickName;
  String? mobileNum;
  int? state;
  int? gender;
  String? birthday;
  String? creatorName;
  String? gmtCreate;
  String? operatorName;
  String? gmtModify;
  String? token;
  String? housingId;
  String? communityName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['account'] = account;
    map['userName'] = userName;
    map['nickName'] = nickName;
    map['mobileNum'] = mobileNum;
    map['state'] = state;
    map['gender'] = gender;
    map['birthday'] = birthday;
    map['creatorName'] = creatorName;
    map['gmtCreate'] = gmtCreate;
    map['operatorName'] = operatorName;
    map['gmtModify'] = gmtModify;
    map['token'] = token;
    map['housingId'] = housingId;
    map['communityName'] = communityName;
    return map;
  }

}