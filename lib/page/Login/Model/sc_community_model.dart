/// id : 1
/// name : "慧享科技园"
/// address : "文艺西路"
/// distance : "<300m"

class SCCommunityModel {
  SCCommunityModel({
      num? id, 
      String? name,
      String? address, 
      String? distance,}){
    _id = id;
    _name = name;
    _address = address;
    _distance = distance;
}

  SCCommunityModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _address = json['address'];
    _distance = json['distance'];
  }
  num? _id;
  String? _name;
  String? _address;
  String? _distance;
  SCCommunityModel copyWith({  num? id,
  String? name,
  String? address,
  String? distance,
}) => SCCommunityModel(  id: id ?? _id,
  name: name ?? _name,
  address: address ?? _address,
  distance: distance ?? _distance,
);
  num? get id => _id;
  String? get name => _name;
  String? get address => _address;
  String? get distance => _distance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['address'] = _address;
    map['distance'] = _distance;
    return map;
  }

}