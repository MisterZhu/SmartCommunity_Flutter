/// id : "122"
/// name : "张三"
/// mobile : "1556876"
/// endDate : "2022-5-29"
/// type : 1   type:人员类型-----暂定------1=业主，2=家属，3=租客,4=朋友

class SCCurrentHouseReviewModel {
  SCCurrentHouseReviewModel({
      String? id, 
      String? name, 
      String? mobile, 
      String? endDate, 
      num? type,}){
    _id = id;
    _name = name;
    _mobile = mobile;
    _endDate = endDate;
    _type = type;
}

  SCCurrentHouseReviewModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _mobile = json['mobile'];
    _endDate = json['endDate'];
    _type = json['type'];
  }
  String? _id;
  String? _name;
  String? _mobile;
  String? _endDate;
  num? _type;
  SCCurrentHouseReviewModel copyWith({  String? id,
  String? name,
  String? mobile,
  String? endDate,
  num? type,
}) => SCCurrentHouseReviewModel(  id: id ?? _id,
  name: name ?? _name,
  mobile: mobile ?? _mobile,
  endDate: endDate ?? _endDate,
  type: type ?? _type,
);
  String? get id => _id;
  String? get name => _name;
  String? get mobile => _mobile;
  String? get endDate => _endDate;
  num? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['mobile'] = _mobile;
    map['endDate'] = _endDate;
    map['type'] = _type;
    return map;
  }

}