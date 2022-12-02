/// applets : [{"icon":{"fileKey":"","name":"","size":0,"suffix":"","type":0},"id":"","name":""}]
/// module : {"id":"","name":""}

class SCServiceModuleModel {
  SCServiceModuleModel({
      List<Applets>? applets, 
      Module? module,}){
    _applets = applets;
    _module = module;
}

  SCServiceModuleModel.fromJson(dynamic json) {
    if (json['applets'] != null) {
      _applets = [];
      json['applets'].forEach((v) {
        _applets?.add(Applets.fromJson(v));
      });
    }
    _module = json['module'] != null ? Module.fromJson(json['module']) : null;
  }
  List<Applets>? _applets;
  Module? _module;
  SCServiceModuleModel copyWith({  List<Applets>? applets,
  Module? module,
}) => SCServiceModuleModel(  applets: applets ?? _applets,
  module: module ?? _module,
);
  List<Applets>? get applets => _applets;
  Module? get module => _module;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_applets != null) {
      map['applets'] = _applets?.map((v) => v.toJson()).toList();
    }
    if (_module != null) {
      map['module'] = _module?.toJson();
    }
    return map;
  }

}

/// id : ""
/// name : ""

class Module {
  Module({
      String? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  Module.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  String? _id;
  String? _name;
Module copyWith({  String? id,
  String? name,
}) => Module(  id: id ?? _id,
  name: name ?? _name,
);
  String? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}

/// icon : {"fileKey":"","name":"","size":0,"suffix":"","type":0}
/// id : ""
/// name : ""

class Applets {
  Applets({
      Icon? icon, 
      String? id, 
      String? name,}){
    _icon = icon;
    _id = id;
    _name = name;
}

  Applets.fromJson(dynamic json) {
    _icon = json['icon'] != null ? Icon.fromJson(json['icon']) : null;
    _id = json['id'];
    _name = json['name'];
  }
  Icon? _icon;
  String? _id;
  String? _name;
Applets copyWith({  Icon? icon,
  String? id,
  String? name,
}) => Applets(  icon: icon ?? _icon,
  id: id ?? _id,
  name: name ?? _name,
);
  Icon? get icon => _icon;
  String? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_icon != null) {
      map['icon'] = _icon?.toJson();
    }
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}

/// fileKey : ""
/// name : ""
/// size : 0
/// suffix : ""
/// type : 0

class Icon {
  Icon({
      String? fileKey, 
      String? name, 
      num? size, 
      String? suffix, 
      num? type,}){
    _fileKey = fileKey;
    _name = name;
    _size = size;
    _suffix = suffix;
    _type = type;
}

  Icon.fromJson(dynamic json) {
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
Icon copyWith({  String? fileKey,
  String? name,
  num? size,
  String? suffix,
  num? type,
}) => Icon(  fileKey: fileKey ?? _fileKey,
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