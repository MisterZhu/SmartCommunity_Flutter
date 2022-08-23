/// id : "38a00451-eb6e-11ea-87e7-6c2b5986eb15"
/// name : "测试小区01"
/// distance : 615
/// address : "浙江省杭州市西湖区蒋村街道西溪国际商务中心B座绿城西溪国际"

class SCCommunityModel {
  SCCommunityModel({
    String? id,
    String? name,
    num? distance,
    String? address,}){
    _id = id;
    _name = name;
    _distance = distance;
    _address = address;
  }

  SCCommunityModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _distance = json['distance'];
    _address = json['address'];
  }
  String? _id;
  String? _name;
  num? _distance;
  String? _address;
  SCCommunityModel copyWith({  String? id,
    String? name,
    num? distance,
    String? address,
  }) => SCCommunityModel(  id: id ?? _id,
    name: name ?? _name,
    distance: distance ?? _distance,
    address: address ?? _address,
  );
  String? get id => _id;
  String? get name => _name;
  num? get distance => _distance;
  String? get address => _address;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['distance'] = _distance;
    map['address'] = _address;
    return map;
  }

}