/// adoptMembers : [{"examineStatus":0,"gmtLiveEnd":"","gmtLiveStart":"","identity":"","identityId":"","name":"","phone":"","relation":0,"residentId":""}]
/// housing : {"communityId":"","communityName":"","enterprise":"","gmtCheckIn":"","gmtDecorate":"","gmtJoin":"","gmtLiveEnd":"","gmtLiveStart":"","gmtQuit":"","id":"","identity":"","identityId":"","isPayer":0,"relation":0,"residenceCertificate":{"fileKey":"","name":"","size":0,"suffix":"","type":0},"residentId":"","spaceId":0,"spaceName":""}
/// underReviewMembers : [{"examineStatus":0,"gmtLiveEnd":"","gmtLiveStart":"","identity":"","identityId":"","name":"","phone":"","relation":0,"residentId":""}]

class ScCurrentHouseInfoDataModel {
  ScCurrentHouseInfoDataModel({
    List<AdoptMembers>? adoptMembers,
    Housing? housing,
    String? spaceType,
    List<AdoptMembers>? underReviewMembers,
  }) {
    _adoptMembers = adoptMembers;
    _housing = housing;
    _spaceType = spaceType;
    _underReviewMembers = underReviewMembers;
  }

  ScCurrentHouseInfoDataModel.fromJson(dynamic json) {
    if (json['adoptMembers'] != null) {
      _adoptMembers = [];
      json['adoptMembers'].forEach((v) {
        _adoptMembers?.add(AdoptMembers.fromJson(v));
      });
    }
    _housing =
        json['housing'] != null ? Housing.fromJson(json['housing']) : null;
    _spaceType = json['spaceType'];
    if (json['underReviewMembers'] != null) {
      _underReviewMembers = [];
      json['underReviewMembers'].forEach((v) {
        _underReviewMembers?.add(AdoptMembers.fromJson(v));
      });
    }
  }

  List<AdoptMembers>? _adoptMembers;
  Housing? _housing;
  String? _spaceType;
  List<AdoptMembers>? _underReviewMembers;

  ScCurrentHouseInfoDataModel copyWith({
    List<AdoptMembers>? adoptMembers,
    Housing? housing,
    List<AdoptMembers>? underReviewMembers,
  }) =>
      ScCurrentHouseInfoDataModel(
        adoptMembers: adoptMembers ?? _adoptMembers,
        housing: housing ?? _housing,
        underReviewMembers: underReviewMembers ?? _underReviewMembers,
      );

  List<AdoptMembers>? get adoptMembers => _adoptMembers;

  Housing? get housing => _housing;

  List<AdoptMembers>? get underReviewMembers => _underReviewMembers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_adoptMembers != null) {
      map['adoptMembers'] = _adoptMembers?.map((v) => v.toJson()).toList();
    }
    if (_housing != null) {
      map['housing'] = _housing?.toJson();
    }
    if (_underReviewMembers != null) {
      map['underReviewMembers'] =
          _underReviewMembers?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// communityId : ""
/// communityName : ""
/// enterprise : ""
/// gmtCheckIn : ""
/// gmtDecorate : ""
/// gmtJoin : ""
/// gmtLiveEnd : ""
/// gmtLiveStart : ""
/// gmtQuit : ""
/// id : ""
/// identity : ""
/// identityId : ""
/// isPayer : 0
/// relation : 0
/// residenceCertificate : {"fileKey":"","name":"","size":0,"suffix":"","type":0}
/// residentId : ""
/// spaceId : 0
/// spaceName : ""

class Housing {
  Housing({
    String? communityId,
    String? communityName,
    String? enterprise,
    String? gmtCheckIn,
    String? gmtDecorate,
    String? gmtJoin,
    String? gmtLiveEnd,
    String? gmtLiveStart,
    String? gmtQuit,
    String? id,
    String? identity,
    String? identityId,
    num? isPayer,
    num? relation,
    ResidenceCertificate? residenceCertificate,
    String? residentId,
    num? spaceId,
    String? spaceName,
  }) {
    _communityId = communityId;
    _communityName = communityName;
    _enterprise = enterprise;
    _gmtCheckIn = gmtCheckIn;
    _gmtDecorate = gmtDecorate;
    _gmtJoin = gmtJoin;
    _gmtLiveEnd = gmtLiveEnd;
    _gmtLiveStart = gmtLiveStart;
    _gmtQuit = gmtQuit;
    _id = id;
    _identity = identity;
    _identityId = identityId;
    _isPayer = isPayer;
    _relation = relation;
    _residenceCertificate = residenceCertificate;
    _residentId = residentId;
    _spaceId = spaceId;
    _spaceName = spaceName;
  }

  Housing.fromJson(dynamic json) {
    _communityId = json['communityId'];
    _communityName = json['communityName'];
    _enterprise = json['enterprise'];
    _gmtCheckIn = json['gmtCheckIn'];
    _gmtDecorate = json['gmtDecorate'];
    _gmtJoin = json['gmtJoin'];
    _gmtLiveEnd = json['gmtLiveEnd'];
    _gmtLiveStart = json['gmtLiveStart'];
    _gmtQuit = json['gmtQuit'];
    _id = json['id'];
    _identity = json['identity'];
    _identityId = json['identityId'];
    _isPayer = json['isPayer'];
    _relation = json['relation'];
    _residenceCertificate = json['residenceCertificate'] != null
        ? ResidenceCertificate.fromJson(json['residenceCertificate'])
        : null;
    _residentId = json['residentId'];
    _spaceId = json['spaceId'];
    _spaceName = json['spaceName'];
  }

  String? _communityId;
  String? _communityName;
  String? _enterprise;
  String? _gmtCheckIn;
  String? _gmtDecorate;
  String? _gmtJoin;
  String? _gmtLiveEnd;
  String? _gmtLiveStart;
  String? _gmtQuit;
  String? _id;
  String? _identity;
  String? _identityId;
  num? _isPayer;
  num? _relation;
  ResidenceCertificate? _residenceCertificate;
  String? _residentId;
  num? _spaceId;
  String? _spaceName;

  Housing copyWith({
    String? communityId,
    String? communityName,
    String? enterprise,
    String? gmtCheckIn,
    String? gmtDecorate,
    String? gmtJoin,
    String? gmtLiveEnd,
    String? gmtLiveStart,
    String? gmtQuit,
    String? id,
    String? identity,
    String? identityId,
    num? isPayer,
    num? relation,
    ResidenceCertificate? residenceCertificate,
    String? residentId,
    num? spaceId,
    String? spaceName,
  }) =>
      Housing(
        communityId: communityId ?? _communityId,
        communityName: communityName ?? _communityName,
        enterprise: enterprise ?? _enterprise,
        gmtCheckIn: gmtCheckIn ?? _gmtCheckIn,
        gmtDecorate: gmtDecorate ?? _gmtDecorate,
        gmtJoin: gmtJoin ?? _gmtJoin,
        gmtLiveEnd: gmtLiveEnd ?? _gmtLiveEnd,
        gmtLiveStart: gmtLiveStart ?? _gmtLiveStart,
        gmtQuit: gmtQuit ?? _gmtQuit,
        id: id ?? _id,
        identity: identity ?? _identity,
        identityId: identityId ?? _identityId,
        isPayer: isPayer ?? _isPayer,
        relation: relation ?? _relation,
        residenceCertificate: residenceCertificate ?? _residenceCertificate,
        residentId: residentId ?? _residentId,
        spaceId: spaceId ?? _spaceId,
        spaceName: spaceName ?? _spaceName,
      );

  String? get communityId => _communityId;

  String? get communityName => _communityName;

  String? get enterprise => _enterprise;

  String? get gmtCheckIn => _gmtCheckIn;

  String? get gmtDecorate => _gmtDecorate;

  String? get gmtJoin => _gmtJoin;

  String? get gmtLiveEnd => _gmtLiveEnd;

  String? get gmtLiveStart => _gmtLiveStart;

  String? get gmtQuit => _gmtQuit;

  String? get id => _id;

  String? get identity => _identity;

  String? get identityId => _identityId;

  num? get isPayer => _isPayer;

  num? get relation => _relation;

  ResidenceCertificate? get residenceCertificate => _residenceCertificate;

  String? get residentId => _residentId;

  num? get spaceId => _spaceId;

  String? get spaceName => _spaceName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['communityId'] = _communityId;
    map['communityName'] = _communityName;
    map['enterprise'] = _enterprise;
    map['gmtCheckIn'] = _gmtCheckIn;
    map['gmtDecorate'] = _gmtDecorate;
    map['gmtJoin'] = _gmtJoin;
    map['gmtLiveEnd'] = _gmtLiveEnd;
    map['gmtLiveStart'] = _gmtLiveStart;
    map['gmtQuit'] = _gmtQuit;
    map['id'] = _id;
    map['identity'] = _identity;
    map['identityId'] = _identityId;
    map['isPayer'] = _isPayer;
    map['relation'] = _relation;
    if (_residenceCertificate != null) {
      map['residenceCertificate'] = _residenceCertificate?.toJson();
    }
    map['residentId'] = _residentId;
    map['spaceId'] = _spaceId;
    map['spaceName'] = _spaceName;
    return map;
  }
}

/// fileKey : ""
/// name : ""
/// size : 0
/// suffix : ""
/// type : 0

class ResidenceCertificate {
  ResidenceCertificate({
    String? fileKey,
    String? name,
    num? size,
    String? suffix,
    num? type,
  }) {
    _fileKey = fileKey;
    _name = name;
    _size = size;
    _suffix = suffix;
    _type = type;
  }

  ResidenceCertificate.fromJson(dynamic json) {
    _fileKey = json['fileKey'];
    _name = json['name'];
    _size = json['size'];
    _suffix = json['suffix'];
    _type = json['type'];
  }

  String? _fileKey;
  String? _name;
  num? _size;
  String? _suffix;
  num? _type;

  ResidenceCertificate copyWith({
    String? fileKey,
    String? name,
    num? size,
    String? suffix,
    num? type,
  }) =>
      ResidenceCertificate(
        fileKey: fileKey ?? _fileKey,
        name: name ?? _name,
        size: size ?? _size,
        suffix: suffix ?? _suffix,
        type: type ?? _type,
      );

  String? get fileKey => _fileKey;

  String? get name => _name;

  num? get size => _size;

  String? get suffix => _suffix;

  num? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fileKey'] = _fileKey;
    map['name'] = _name;
    map['size'] = _size;
    map['suffix'] = _suffix;
    map['type'] = _type;
    return map;
  }
}

/// examineStatus : 0
/// gmtLiveEnd : ""
/// gmtLiveStart : ""
/// identity : ""
/// identityId : ""
/// name : ""
/// phone : ""
/// relation : 0
/// residentId : ""

class AdoptMembers {
  AdoptMembers({
    num? examineStatus,
    String? gmtLiveEnd,
    String? gmtLiveStart,
    String? identity,
    String? identityId,
    String? name,
    String? phone,
    num? relation,
    String? residentId,
  }) {
    _examineStatus = examineStatus;
    _gmtLiveEnd = gmtLiveEnd;
    _gmtLiveStart = gmtLiveStart;
    _identity = identity;
    _identityId = identityId;
    _name = name;
    _phone = phone;
    _relation = relation;
    _residentId = residentId;
  }

  AdoptMembers.fromJson(dynamic json) {
    _examineStatus = json['examineStatus'];
    _gmtLiveEnd = json['gmtLiveEnd'];
    _gmtLiveStart = json['gmtLiveStart'];
    _identity = json['identity'];
    _identityId = json['identityId'];
    _name = json['name'];
    _phone = json['phone'];
    _relation = json['relation'];
    _residentId = json['residentId'];
  }

  num? _examineStatus;
  String? _gmtLiveEnd;
  String? _gmtLiveStart;
  String? _identity;
  String? _identityId;
  String? _name;
  String? _phone;
  num? _relation;
  String? _residentId;

  AdoptMembers copyWith({
    num? examineStatus,
    String? gmtLiveEnd,
    String? gmtLiveStart,
    String? identity,
    String? identityId,
    String? name,
    String? phone,
    num? relation,
    String? residentId,
  }) =>
      AdoptMembers(
        examineStatus: examineStatus ?? _examineStatus,
        gmtLiveEnd: gmtLiveEnd ?? _gmtLiveEnd,
        gmtLiveStart: gmtLiveStart ?? _gmtLiveStart,
        identity: identity ?? _identity,
        identityId: identityId ?? _identityId,
        name: name ?? _name,
        phone: phone ?? _phone,
        relation: relation ?? _relation,
        residentId: residentId ?? _residentId,
      );

  num? get examineStatus => _examineStatus;

  String? get gmtLiveEnd => _gmtLiveEnd;

  String? get gmtLiveStart => _gmtLiveStart;

  String? get identity => _identity;

  String? get identityId => _identityId;

  String? get name => _name;

  String? get phone => _phone;

  num? get relation => _relation;

  String? get residentId => _residentId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['examineStatus'] = _examineStatus;
    map['gmtLiveEnd'] = _gmtLiveEnd;
    map['gmtLiveStart'] = _gmtLiveStart;
    map['identity'] = _identity;
    map['identityId'] = _identityId;
    map['name'] = _name;
    map['phone'] = _phone;
    map['relation'] = _relation;
    map['residentId'] = _residentId;
    return map;
  }
}
