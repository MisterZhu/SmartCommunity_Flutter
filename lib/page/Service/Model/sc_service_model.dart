/// id : "111"
/// icon : "imag"
/// name : "hello"
/// added : false

class SCServiceModel {
  SCServiceModel({
      String? id, 
      String? icon, 
      String? name, 
      bool? added,}){
    _id = id;
    _icon = icon;
    _name = name;
    _added = added;
}

  SCServiceModel.fromJson(dynamic json) {
    _id = json['id'];
    _icon = json['icon'];
    _name = json['name'];
    _added = json['added'];
  }
  String? _id;
  String? _icon;
  String? _name;
  bool? _added;
SCServiceModel copyWith({  String? id,
  String? icon,
  String? name,
  bool? added,
}) => SCServiceModel(  id: id ?? _id,
  icon: icon ?? _icon,
  name: name ?? _name,
  added: added ?? _added,
);
  String? get id => _id;
  String? get icon => _icon;
  String? get name => _name;
  bool? get added => _added;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['icon'] = _icon;
    map['name'] = _name;
    map['added'] = _added;
    return map;
  }

}