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

class ScSelectHouseModel {
  int? id;
  String? name;
  String? pid;
  String? communityId;
  int? isAsset; //是否可以是资产：0：否，1是
  num? type;
  String? typeName;
  String? typeNameFlag;
  String? floor;
  bool? haveChild;
  bool? isChecked = false;

  ScSelectHouseModel({
    required this.id,
    this.name,
    this.pid,
    this.communityId,
    this.type,
    this.typeName,
    this.isAsset,
    this.typeNameFlag,
    this.floor,
    this.haveChild,
    this.isChecked,
  });

  ScSelectHouseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pid = json['pid'];
    communityId = json['communityId'];
    type = json['type'];
    isAsset = json['isAsset'];
    typeName = json['typeName'];
    typeNameFlag = json['typeNameFlag'];
    floor = json['floor'];
    haveChild = json['haveChild'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['pid'] = pid;
    map['communityId'] = communityId;
    map['type'] = type;
    map['isAsset'] = isAsset;
    map['typeName'] = typeName;
    map['typeNameFlag'] = typeNameFlag;
    map['floor'] = floor;
    map['haveChild'] = haveChild;
    return map;
  }

  @override
  String toString() {
    return 'ScSelectHouseModel{id: $id, name: $name, pid: $pid, communityId: $communityId, type: $type, isAsset: $isAsset, typeName: $typeName, typeNameFlag: $typeNameFlag, floor: $floor, haveChild: $haveChild, isChecked: $isChecked}';
  }
}
