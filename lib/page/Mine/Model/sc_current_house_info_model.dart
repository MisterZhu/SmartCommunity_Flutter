/// id : "1122"
/// houseNumber : "11"
/// houseType : 1  房屋类型1=住宅，
/// owner : "张三"
/// identity : 1  本人身份:1业主
/// endDate : "2033-3-8"

class SCCurrentHouseInfoModel {
  SCCurrentHouseInfoModel({
      String? id, 
      String? houseNumber, 
      num? houseType, 
      String? owner, 
      num? identity, 
      String? endDate,}){
    _id = id;
    _houseNumber = houseNumber;
    _houseType = houseType;
    _owner = owner;
    _identity = identity;
    _endDate = endDate;
}

  SCCurrentHouseInfoModel.fromJson(dynamic json) {
    _id = json['id'];
    _houseNumber = json['houseNumber'];
    _houseType = json['houseType'];
    _owner = json['owner'];
    _identity = json['identity'];
    _endDate = json['endDate'];
  }
  String? _id;
  String? _houseNumber;
  num? _houseType;
  String? _owner;
  num? _identity;
  String? _endDate;
  SCCurrentHouseInfoModel copyWith({  String? id,
  String? houseNumber,
  num? houseType,
  String? owner,
  num? identity,
  String? endDate,
}) => SCCurrentHouseInfoModel(  id: id ?? _id,
  houseNumber: houseNumber ?? _houseNumber,
  houseType: houseType ?? _houseType,
  owner: owner ?? _owner,
  identity: identity ?? _identity,
  endDate: endDate ?? _endDate,
);
  String? get id => _id;
  String? get houseNumber => _houseNumber;
  num? get houseType => _houseType;
  String? get owner => _owner;
  num? get identity => _identity;
  String? get endDate => _endDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['houseNumber'] = _houseNumber;
    map['houseType'] = _houseType;
    map['owner'] = _owner;
    map['identity'] = _identity;
    map['endDate'] = _endDate;
    return map;
  }

}