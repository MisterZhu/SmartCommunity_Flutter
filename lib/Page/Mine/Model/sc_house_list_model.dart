/// id : "125361807315201"
/// userId : "167386837195085"
/// communityId : "38f258cd-89c7-11ea-bf80-005056b167dc"
/// communityName : "海滨项目"
/// spaceId : 10987168128206
/// spaceName : "海滨项目-天香苑修改后"
/// spaceTypeId : 10980035640813
/// identityId : "112276707864191"
/// examineStatus : 1    ///审核状态 0 审核中 1 审核通过 2 审核拒绝
/// identity : "房东"
/// identityType : 1
/// relation : 0
/// isPayer : 1
/// residenceCertificate : ""
/// gmtJoin : ""
/// gmtCheckIn : ""
/// gmtDecorate : ""
/// gmtQuit : ""
/// gmtLiveStart : ""
/// gmtLiveEnd : ""
/// enterprise : ""

class SCHouseListModel {
  SCHouseListModel({
      String? id,
      String? userId,
      String? communityId, 
      String? communityName, 
      int? spaceId, 
      String? spaceName, 
      int? spaceTypeId, 
      String? identityId,
      int? examineStatus, 
      String? identity, 
      int? identityType, 
      int? relation, 
      int? isPayer, 
      String? residenceCertificate, 
      String? gmtJoin, 
      String? gmtCheckIn, 
      String? gmtDecorate, 
      String? gmtQuit, 
      String? gmtLiveStart, 
      String? gmtLiveEnd, 
      String? enterprise,}){
    _id = id;
    _userId = userId;
    _communityId = communityId;
    _communityName = communityName;
    _spaceId = spaceId;
    _spaceName = spaceName;
    _spaceTypeId = spaceTypeId;
    _identityId = identityId;
    _examineStatus = examineStatus;
    _identity = identity;
    _identityType = identityType;
    _relation = relation;
    _isPayer = isPayer;
    _residenceCertificate = residenceCertificate;
    _gmtJoin = gmtJoin;
    _gmtCheckIn = gmtCheckIn;
    _gmtDecorate = gmtDecorate;
    _gmtQuit = gmtQuit;
    _gmtLiveStart = gmtLiveStart;
    _gmtLiveEnd = gmtLiveEnd;
    _enterprise = enterprise;
}

  SCHouseListModel.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['userId'];
    _communityId = json['communityId'];
    _communityName = json['communityName'];
    _spaceId = json['spaceId'];
    _spaceName = json['spaceName'];
    _spaceTypeId = json['spaceTypeId'];
    _identityId = json['identityId'];
    _examineStatus = json['examineStatus'];
    _identity = json['identity'];
    _identityType = json['identityType'];
    _relation = json['relation'];
    _isPayer = json['isPayer'];
    _residenceCertificate = json['residenceCertificate'];
    _gmtJoin = json['gmtJoin'];
    _gmtCheckIn = json['gmtCheckIn'];
    _gmtDecorate = json['gmtDecorate'];
    _gmtQuit = json['gmtQuit'];
    _gmtLiveStart = json['gmtLiveStart'];
    _gmtLiveEnd = json['gmtLiveEnd'];
    _enterprise = json['enterprise'];
  }
  String? _id;
  String? _userId;
  String? _communityId;
  String? _communityName;
  int? _spaceId;
  String? _spaceName;
  int? _spaceTypeId;
  String? _identityId;
  int? _examineStatus;
  String? _identity;
  int? _identityType;
  int? _relation;
  int? _isPayer;
  String? _residenceCertificate;
  String? _gmtJoin;
  String? _gmtCheckIn;
  String? _gmtDecorate;
  String? _gmtQuit;
  String? _gmtLiveStart;
  String? _gmtLiveEnd;
  String? _enterprise;
  SCHouseListModel copyWith({  String? id,
  String? userId,
  String? communityId,
  String? communityName,
  int? spaceId,
  String? spaceName,
  int? spaceTypeId,
  String? identityId,
  int? examineStatus,
  String? identity,
  int? identityType,
  int? relation,
  int? isPayer,
  String? residenceCertificate,
  String? gmtJoin,
  String? gmtCheckIn,
  String? gmtDecorate,
  String? gmtQuit,
  String? gmtLiveStart,
  String? gmtLiveEnd,
  String? enterprise,
}) => SCHouseListModel(  id: id ?? _id,
  userId: userId ?? _userId,
  communityId: communityId ?? _communityId,
  communityName: communityName ?? _communityName,
  spaceId: spaceId ?? _spaceId,
  spaceName: spaceName ?? _spaceName,
  spaceTypeId: spaceTypeId ?? _spaceTypeId,
  identityId: identityId ?? _identityId,
  examineStatus: examineStatus ?? _examineStatus,
  identity: identity ?? _identity,
  identityType: identityType ?? _identityType,
  relation: relation ?? _relation,
  isPayer: isPayer ?? _isPayer,
  residenceCertificate: residenceCertificate ?? _residenceCertificate,
  gmtJoin: gmtJoin ?? _gmtJoin,
  gmtCheckIn: gmtCheckIn ?? _gmtCheckIn,
  gmtDecorate: gmtDecorate ?? _gmtDecorate,
  gmtQuit: gmtQuit ?? _gmtQuit,
  gmtLiveStart: gmtLiveStart ?? _gmtLiveStart,
  gmtLiveEnd: gmtLiveEnd ?? _gmtLiveEnd,
  enterprise: enterprise ?? _enterprise,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get communityId => _communityId;
  String? get communityName => _communityName;
  int? get spaceId => _spaceId;
  String? get spaceName => _spaceName;
  int? get spaceTypeId => _spaceTypeId;
  String? get identityId => _identityId;
  int? get examineStatus => _examineStatus;
  String? get identity => _identity;
  int? get identityType => _identityType;
  int? get relation => _relation;
  int? get isPayer => _isPayer;
  String? get residenceCertificate => _residenceCertificate;
  String? get gmtJoin => _gmtJoin;
  String? get gmtCheckIn => _gmtCheckIn;
  String? get gmtDecorate => _gmtDecorate;
  String? get gmtQuit => _gmtQuit;
  String? get gmtLiveStart => _gmtLiveStart;
  String? get gmtLiveEnd => _gmtLiveEnd;
  String? get enterprise => _enterprise;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userId'] = _userId;
    map['communityId'] = _communityId;
    map['communityName'] = _communityName;
    map['spaceId'] = _spaceId;
    map['spaceName'] = _spaceName;
    map['spaceTypeId'] = _spaceTypeId;
    map['identityId'] = _identityId;
    map['examineStatus'] = _examineStatus;
    map['identity'] = _identity;
    map['identityType'] = _identityType;
    map['relation'] = _relation;
    map['isPayer'] = _isPayer;
    map['residenceCertificate'] = _residenceCertificate;
    map['gmtJoin'] = _gmtJoin;
    map['gmtCheckIn'] = _gmtCheckIn;
    map['gmtDecorate'] = _gmtDecorate;
    map['gmtQuit'] = _gmtQuit;
    map['gmtLiveStart'] = _gmtLiveStart;
    map['gmtLiveEnd'] = _gmtLiveEnd;
    map['enterprise'] = _enterprise;
    return map;
  }

}