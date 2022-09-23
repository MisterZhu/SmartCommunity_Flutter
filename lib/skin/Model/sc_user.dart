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
      this.communityId,
      this.communityName,
      this.housingId,
      this.spaceId,
      this.spaceName,
      this.identityId,
      this.identityName,
      this.defaultConfigId
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
    communityId = json['communityId'];
    communityName = json['communityName'];
    housingId = json['housingId'];
    spaceId = json['spaceId'];
    spaceName = json['spaceName'];
    identityId = json['identityId'];
    identityName = json['identityName'];
    defaultConfigId = json['defaultConfigId'];
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
  String? communityId;
  String? communityName;
  String? housingId;
  num? spaceId;
  String? spaceName;
  String? identityId;
  String? identityName;
  num? defaultConfigId;

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
    map['communityId'] = communityId;
    map['communityName'] = communityName;
    map['housingId'] = housingId;
    map['spaceId'] = spaceId;
    map['spaceName'] = spaceName;
    map['identityId'] = identityId;
    map['identityName'] = identityName;
    map['defaultConfigId'] = defaultConfigId;
    return map;
  }

  @override
  String toString() {
    return 'SCUser{id: $id, account: $account, userName: $userName, nickName: $nickName, mobileNum: $mobileNum, state: $state, gender: $gender, birthday: $birthday, creatorName: $creatorName, gmtCreate: $gmtCreate, operatorName: $operatorName, gmtModify: $gmtModify, token: $token, communityId: $communityId, communityName: $communityName, housingId: $housingId, spaceId: $spaceId, spaceName: $spaceName, identityId: $identityId, identityName: $identityName, defaultConfigId: $defaultConfigId}';
  }
}