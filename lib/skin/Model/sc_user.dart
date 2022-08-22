/// userInfoV : {"id":"b1f51257-0fd7-411a-adeb-41bfd5a53906","account":"13221028695","userName":"沙宁宁","nickName":"慧享","mobileNum":"13221028695","state":0,"gender":1,"birthday":"1984-10-07","creatorName":"超级管理员","gmtCreate":"2022-05-23 16:00:27","operatorName":"超级管理员","gmtModify":"2022-05-23 16:00:27","token":""}

class SCUser {
  SCUser({
      UserInfoV? userInfoV,}){
    _userInfoV = userInfoV;
}

  SCUser.fromJson(dynamic json) {
    _userInfoV = json['userInfoV'] != null ? UserInfoV.fromJson(json['userInfoV']) : null;
  }
  UserInfoV? _userInfoV;
  SCUser copyWith({  UserInfoV? userInfoV,
}) => SCUser(  userInfoV: userInfoV ?? _userInfoV,
);
  UserInfoV? get userInfoV => _userInfoV;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_userInfoV != null) {
      map['userInfoV'] = _userInfoV?.toJson();
    }
    return map;
  }

}

/// id : "b1f51257-0fd7-411a-adeb-41bfd5a53906"
/// account : "13221028695"
/// userName : "沙宁宁"
/// nickName : "慧享"
/// mobileNum : "13221028695"
/// state : 0
/// gender : 1
/// birthday : "1984-10-07"
/// creatorName : "超级管理员"
/// gmtCreate : "2022-05-23 16:00:27"
/// operatorName : "超级管理员"
/// gmtModify : "2022-05-23 16:00:27"
/// token : ""

class UserInfoV {
  UserInfoV({
      String? id, 
      String? account, 
      String? userName, 
      String? nickName, 
      String? mobileNum, 
      num? state, 
      num? gender, 
      String? birthday, 
      String? creatorName, 
      String? gmtCreate, 
      String? operatorName, 
      String? gmtModify, 
      String? token,}){
    _id = id;
    _account = account;
    _userName = userName;
    _nickName = nickName;
    _mobileNum = mobileNum;
    _state = state;
    _gender = gender;
    _birthday = birthday;
    _creatorName = creatorName;
    _gmtCreate = gmtCreate;
    _operatorName = operatorName;
    _gmtModify = gmtModify;
    _token = token;
}

  UserInfoV.fromJson(dynamic json) {
    _id = json['id'];
    _account = json['account'];
    _userName = json['userName'];
    _nickName = json['nickName'];
    _mobileNum = json['mobileNum'];
    _state = json['state'];
    _gender = json['gender'];
    _birthday = json['birthday'];
    _creatorName = json['creatorName'];
    _gmtCreate = json['gmtCreate'];
    _operatorName = json['operatorName'];
    _gmtModify = json['gmtModify'];
    _token = json['token'];
  }
  String? _id;
  String? _account;
  String? _userName;
  String? _nickName;
  String? _mobileNum;
  num? _state;
  num? _gender;
  String? _birthday;
  String? _creatorName;
  String? _gmtCreate;
  String? _operatorName;
  String? _gmtModify;
  String? _token;
UserInfoV copyWith({  String? id,
  String? account,
  String? userName,
  String? nickName,
  String? mobileNum,
  num? state,
  num? gender,
  String? birthday,
  String? creatorName,
  String? gmtCreate,
  String? operatorName,
  String? gmtModify,
  String? token,
}) => UserInfoV(  id: id ?? _id,
  account: account ?? _account,
  userName: userName ?? _userName,
  nickName: nickName ?? _nickName,
  mobileNum: mobileNum ?? _mobileNum,
  state: state ?? _state,
  gender: gender ?? _gender,
  birthday: birthday ?? _birthday,
  creatorName: creatorName ?? _creatorName,
  gmtCreate: gmtCreate ?? _gmtCreate,
  operatorName: operatorName ?? _operatorName,
  gmtModify: gmtModify ?? _gmtModify,
  token: token ?? _token,
);
  String? get id => _id;
  String? get account => _account;
  String? get userName => _userName;
  String? get nickName => _nickName;
  String? get mobileNum => _mobileNum;
  num? get state => _state;
  num? get gender => _gender;
  String? get birthday => _birthday;
  String? get creatorName => _creatorName;
  String? get gmtCreate => _gmtCreate;
  String? get operatorName => _operatorName;
  String? get gmtModify => _gmtModify;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['account'] = _account;
    map['userName'] = _userName;
    map['nickName'] = _nickName;
    map['mobileNum'] = _mobileNum;
    map['state'] = _state;
    map['gender'] = _gender;
    map['birthday'] = _birthday;
    map['creatorName'] = _creatorName;
    map['gmtCreate'] = _gmtCreate;
    map['operatorName'] = _operatorName;
    map['gmtModify'] = _gmtModify;
    map['token'] = _token;
    return map;
  }

}