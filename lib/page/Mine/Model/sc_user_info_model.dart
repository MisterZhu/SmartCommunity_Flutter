import 'package:smartcommunity/page/Mine/Model/sc_upload_headpic_model.dart';

/// account : ""
/// birthday : ""
/// gender : 0
/// headPicUri : {"fileKey":"","name":"","size":1.0,"suffix":"","type":0}
/// id : ""
/// mobileNum : ""
/// nickName : ""
/// userName : ""

class SCUserInfoModel {
  SCUserInfoModel({
    String? account,
    String? birthday,
    int? gender,
    SCUploadHeadPicModel? headPicUri,
    String? id,
    String? mobileNum,
    String? nickName,
    String? userName,
  }) {
    _account = account;
    _birthday = birthday;
    _gender = gender;
    _headPicUri = headPicUri;
    _id = id;
    _mobileNum = mobileNum;
    _nickName = nickName;
    _userName = userName;
  }

  SCUserInfoModel.fromJson(dynamic json) {
    _account = json['account'];
    _birthday = json['birthday'];
    _gender = json['gender'];
    _headPicUri = json['headPicUri'] != null
        ? SCUploadHeadPicModel.fromJson(json['headPicUri'])
        : null;
    _id = json['id'];
    _mobileNum = json['mobileNum'];
    _nickName = json['nickName'];
    _userName = json['userName'];
  }
  String? _account;
  String? _birthday;
  int? _gender;
  SCUploadHeadPicModel? _headPicUri;
  String? _id;
  String? _mobileNum;
  String? _nickName;
  String? _userName;
  SCUserInfoModel copyWith({
    String? account,
    String? birthday,
    int? gender,
    SCUploadHeadPicModel? headPicUri,
    String? id,
    String? mobileNum,
    String? nickName,
    String? userName,
  }) =>
      SCUserInfoModel(
        account: account ?? _account,
        birthday: birthday ?? _birthday,
        gender: gender ?? _gender,
        headPicUri: headPicUri ?? _headPicUri,
        id: id ?? _id,
        mobileNum: mobileNum ?? _mobileNum,
        nickName: nickName ?? _nickName,
        userName: userName ?? _userName,
      );
  String? get account => _account;
  String? get birthday => _birthday;
  int? get gender => _gender;
  SCUploadHeadPicModel? get headPicUri => _headPicUri;
  String? get id => _id;
  String? get mobileNum => _mobileNum;
  String? get nickName => _nickName;
  String? get userName => _userName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['account'] = _account;
    map['birthday'] = _birthday;
    map['gender'] = _gender;
    if (_headPicUri != null) {
      map['headPicUri'] = _headPicUri?.toJson();
    }
    map['id'] = _id;
    map['mobileNum'] = _mobileNum;
    map['nickName'] = _nickName;
    map['userName'] = _userName;
    return map;
  }
}
