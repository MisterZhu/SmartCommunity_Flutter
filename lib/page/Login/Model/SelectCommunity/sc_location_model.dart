/// addressComponent : {"city":"杭州市","province":"浙江省","adcode":"330106","district":"西湖区","towncode":"330106012000","streetNumber":{"number":"116号","location":"120.062373,30.287785","direction":"东北","distance":"4.12395","street":"崇义路"},"country":"中国","township":"蒋村街道","businessAreas":[{"location":"120.091030,30.271791","name":"西溪","id":"330106"}],"citycode":"0571"}
/// formatted_address : "浙江省杭州市西湖区蒋村街道崇义路116号西溪蝶园"

class SCLocationModel {
  SCLocationModel({
      AddressComponent? addressComponent, 
      String? formattedAddress,}){
    _addressComponent = addressComponent;
    _formattedAddress = formattedAddress;
}

  SCLocationModel.fromJson(dynamic json) {
    _addressComponent = json['addressComponent'] != null ? AddressComponent.fromJson(json['addressComponent']) : null;
    _formattedAddress = json['formatted_address'];
  }
  AddressComponent? _addressComponent;
  String? _formattedAddress;
  SCLocationModel copyWith({  AddressComponent? addressComponent,
  String? formattedAddress,
}) => SCLocationModel(  addressComponent: addressComponent ?? _addressComponent,
  formattedAddress: formattedAddress ?? _formattedAddress,
);
  AddressComponent? get addressComponent => _addressComponent;
  String? get formattedAddress => _formattedAddress;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_addressComponent != null) {
      map['addressComponent'] = _addressComponent?.toJson();
    }
    map['formatted_address'] = _formattedAddress;
    return map;
  }

}

/// city : "杭州市"
/// province : "浙江省"
/// adcode : "330106"
/// district : "西湖区"
/// towncode : "330106012000"
/// streetNumber : {"number":"116号","location":"120.062373,30.287785","direction":"东北","distance":"4.12395","street":"崇义路"}
/// country : "中国"
/// township : "蒋村街道"
/// businessAreas : [{"location":"120.091030,30.271791","name":"西溪","id":"330106"}]
/// citycode : "0571"

class AddressComponent {
  AddressComponent({
      String? city, 
      String? province, 
      String? adcode, 
      String? district, 
      String? towncode, 
      StreetNumber? streetNumber, 
      String? country, 
      String? township, 
      List<BusinessAreas>? businessAreas, 
      String? citycode,}){
    _city = city;
    _province = province;
    _adcode = adcode;
    _district = district;
    _towncode = towncode;
    _streetNumber = streetNumber;
    _country = country;
    _township = township;
    _businessAreas = businessAreas;
    _citycode = citycode;
}

  AddressComponent.fromJson(dynamic json) {
    _city = json['city'];
    _province = json['province'];
    _adcode = json['adcode'];
    _district = json['district'];
    _towncode = json['towncode'];
    _streetNumber = json['streetNumber'] != null ? StreetNumber.fromJson(json['streetNumber']) : null;
    _country = json['country'];
    _township = json['township'];
    if (json['businessAreas'] != null) {
      _businessAreas = [];
      json['businessAreas'].forEach((v) {
        _businessAreas?.add(BusinessAreas.fromJson(v));
      });
    }
    _citycode = json['citycode'];
  }
  String? _city;
  String? _province;
  String? _adcode;
  String? _district;
  String? _towncode;
  StreetNumber? _streetNumber;
  String? _country;
  String? _township;
  List<BusinessAreas>? _businessAreas;
  String? _citycode;
AddressComponent copyWith({  String? city,
  String? province,
  String? adcode,
  String? district,
  String? towncode,
  StreetNumber? streetNumber,
  String? country,
  String? township,
  List<BusinessAreas>? businessAreas,
  String? citycode,
}) => AddressComponent(  city: city ?? _city,
  province: province ?? _province,
  adcode: adcode ?? _adcode,
  district: district ?? _district,
  towncode: towncode ?? _towncode,
  streetNumber: streetNumber ?? _streetNumber,
  country: country ?? _country,
  township: township ?? _township,
  businessAreas: businessAreas ?? _businessAreas,
  citycode: citycode ?? _citycode,
);
  String? get city => _city;
  String? get province => _province;
  String? get adcode => _adcode;
  String? get district => _district;
  String? get towncode => _towncode;
  StreetNumber? get streetNumber => _streetNumber;
  String? get country => _country;
  String? get township => _township;
  List<BusinessAreas>? get businessAreas => _businessAreas;
  String? get citycode => _citycode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['city'] = _city;
    map['province'] = _province;
    map['adcode'] = _adcode;
    map['district'] = _district;
    map['towncode'] = _towncode;
    if (_streetNumber != null) {
      map['streetNumber'] = _streetNumber?.toJson();
    }
    map['country'] = _country;
    map['township'] = _township;
    if (_businessAreas != null) {
      map['businessAreas'] = _businessAreas?.map((v) => v.toJson()).toList();
    }
    map['citycode'] = _citycode;
    return map;
  }

}

/// location : "120.091030,30.271791"
/// name : "西溪"
/// id : "330106"

class BusinessAreas {
  BusinessAreas({
      String? location, 
      String? name, 
      String? id,}){
    _location = location;
    _name = name;
    _id = id;
}

  BusinessAreas.fromJson(dynamic json) {
    _location = json['location'];
    _name = json['name'];
    _id = json['id'];
  }
  String? _location;
  String? _name;
  String? _id;
BusinessAreas copyWith({  String? location,
  String? name,
  String? id,
}) => BusinessAreas(  location: location ?? _location,
  name: name ?? _name,
  id: id ?? _id,
);
  String? get location => _location;
  String? get name => _name;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['location'] = _location;
    map['name'] = _name;
    map['id'] = _id;
    return map;
  }

}

/// number : "116号"
/// location : "120.062373,30.287785"
/// direction : "东北"
/// distance : "4.12395"
/// street : "崇义路"

class StreetNumber {
  StreetNumber({
      List? number,
      String? location,
      List? direction,
      List? distance,
      List? street,}){
    _number = number;
    _location = location;
    _direction = direction;
    _distance = distance;
    _street = street;
}

  StreetNumber.fromJson(dynamic json) {
    _number = json['number'];
    _location = json['location'];
    _direction = json['direction'];
    _distance = json['distance'];
    _street = json['street'];
  }
  List? _number;
  String? _location;
  List? _direction;
  List? _distance;
  List? _street;
StreetNumber copyWith({  List? number,
  String? location,
  List? direction,
  List? distance,
  List? street,
}) => StreetNumber(  number: number ?? _number,
  location: location ?? _location,
  direction: direction ?? _direction,
  distance: distance ?? _distance,
  street: street ?? _street,
);
  List? get number => _number;
  String? get location => _location;
  List? get direction => _direction;
  List? get distance => _distance;
  List? get street => _street;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['number'] = _number;
    map['location'] = _location;
    map['direction'] = _direction;
    map['distance'] = _distance;
    map['street'] = _street;
    return map;
  }

}