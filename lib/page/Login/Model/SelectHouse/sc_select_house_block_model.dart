/// id : 10985520020810
/// name : "1幢"
/// pid : "004759ef-5fcc-4d6c-9345-0526bce3e54a"
/// communityId : "004759ef-5fcc-4d6c-9345-0526bce3e54a"
/// type : 10985424502007
/// typeName : "幢"
/// typeNameFlag : ""
/// floor : ""
/// haveChild : true
/// isChecked : true

class ScSelectHouseBlockModel {
  ScSelectHouseBlockModel({
      num? id, 
      String? name, 
      String? pid, 
      String? communityId, 
      num? type, 
      String? typeName, 
      String? typeNameFlag, 
      String? floor, 
      bool? haveChild,}){
    _id = id;
    _name = name;
    _pid = pid;
    _communityId = communityId;
    _type = type;
    _typeName = typeName;
    _typeNameFlag = typeNameFlag;
    _floor = floor;
    _haveChild = haveChild;
}

  ScSelectHouseBlockModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _pid = json['pid'];
    _communityId = json['communityId'];
    _type = json['type'];
    _typeName = json['typeName'];
    _typeNameFlag = json['typeNameFlag'];
    _floor = json['floor'];
    _haveChild = json['haveChild'];
  }
  num? _id;
  String? _name;
  String? _pid;
  String? _communityId;
  num? _type;
  String? _typeName;
  String? _typeNameFlag;
  String? _floor;
  bool? _haveChild;
  bool? _isChecked;
ScSelectHouseBlockModel copyWith({  num? id,
  String? name,
  String? pid,
  String? communityId,
  num? type,
  String? typeName,
  String? typeNameFlag,
  String? floor,
  bool? haveChild,
  bool? isChecked,
}) => ScSelectHouseBlockModel(  id: id ?? _id,
  name: name ?? _name,
  pid: pid ?? _pid,
  communityId: communityId ?? _communityId,
  type: type ?? _type,
  typeName: typeName ?? _typeName,
  typeNameFlag: typeNameFlag ?? _typeNameFlag,
  floor: floor ?? _floor,
  haveChild: haveChild ?? _haveChild,
);
  num? get id => _id;
  String? get name => _name;
  String? get pid => _pid;
  String? get communityId => _communityId;
  num? get type => _type;
  String? get typeName => _typeName;
  String? get typeNameFlag => _typeNameFlag;
  String? get floor => _floor;
  bool? get haveChild => _haveChild;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['pid'] = _pid;
    map['communityId'] = _communityId;
    map['type'] = _type;
    map['typeName'] = _typeName;
    map['typeNameFlag'] = _typeNameFlag;
    map['floor'] = _floor;
    map['haveChild'] = _haveChild;
    return map;
  }

}