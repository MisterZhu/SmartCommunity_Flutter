/// fileKey : ""
/// name : ""
/// suffix : ""
/// size : 1.0
/// type : 1

/// 上传用户头像model

class SCUploadHeadPicModel {
  SCUploadHeadPicModel({
      String? fileKey, 
      String? name, 
      String? suffix, 
      num? size, 
      num? type,}){
    _fileKey = fileKey;
    _name = name;
    _suffix = suffix;
    _size = size;
    _type = type;
}

  SCUploadHeadPicModel.fromJson(dynamic json) {
    _fileKey = json['fileKey'];
    _name = json['name'];
    _suffix = json['suffix'];
    _size = json['size'];
    _type = json['type'];
  }
  String? _fileKey;
  String? _name;
  String? _suffix;
  num? _size;
  num? _type;
  SCUploadHeadPicModel copyWith({  String? fileKey,
  String? name,
  String? suffix,
  num? size,
  num? type,
}) => SCUploadHeadPicModel(  fileKey: fileKey ?? _fileKey,
  name: name ?? _name,
  suffix: suffix ?? _suffix,
  size: size ?? _size,
  type: type ?? _type,
);
  String? get fileKey => _fileKey;
  String? get name => _name;
  String? get suffix => _suffix;
  num? get size => _size;
  num? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fileKey'] = _fileKey;
    map['name'] = _name;
    map['suffix'] = _suffix;
    map['size'] = _size;
    map['type'] = _type;
    return map;
  }

}