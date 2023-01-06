/// info : {"id":12171107797803,"name":"善数游客2","type":2,"effect":true,"operator":"11165381959503","operatorName":"寇进男","gmtModify":"2022-12-27 16:50:13"}
/// overallDecoration : {"bottomNavigation":{"iconLocation":0,"navigationList":[{"id":12171107800106,"patternId":12171107797803,"title":"首页","link":12171107798206,"icon":"11893949688304","iconInfo":{"id":11893949688304,"checked":"wishare-applet/decoration/pattern/AppletPatternE/118939418628402/20221125/1669358618629102.png","unchecked":"wishare-applet/decoration/pattern/AppletPatternE/118939394376401/20221125/1669358594394101.png"},"sort":0},{"id":12171107800108,"patternId":12171107797803,"title":"我的","link":12171107798206,"icon":"11893949688304","iconInfo":{"id":11893949688304,"checked":"wishare-applet/decoration/pattern/AppletPatternE/118939418628402/20221125/1669358618629102.png","unchecked":"wishare-applet/decoration/pattern/AppletPatternE/118939394376401/20221125/1669358594394101.png"},"sort":0}]},"themeColor":null}
/// pageDecorationList : [{"id":12171107798206,"name":"首页","sort":0,"componentList":[{"id":12171107799107,"patternId":12171107797803,"pageDecorationId":12171107798206,"componentId":1,"name":"轮播图","info":"{\"autoplaySpeed\":3,\"advertisementImgList\":[{\"fileKey\":\"wishare-applet/decoration/pattern/AppletPatternE/121711641905107/20221227/1672130841905107.png\",\"name\":\"s1.png\",\"suffix\":\"png\",\"size\":181515,\"type\":1},{\"fileKey\":\"wishare-applet/decoration/pattern/AppletPatternE/121711652453108/20221227/1672130852454108.png\",\"name\":\"s2.png\",\"suffix\":\"png\",\"size\":354843,\"type\":1},{\"fileKey\":\"wishare-applet/decoration/pattern/AppletPatternE/121711666228012/20221227/1672130866228112.png\",\"name\":\"s3.png\",\"suffix\":\"png\",\"size\":361888,\"type\":1}]}"}]},{"id":12171107798208,"name":"我的","sort":0,"componentList":[{"id":12171107799110,"patternId":12171107797803,"pageDecorationId":12171107798208,"componentId":4,"name":"背景图","info":"{\"fileKey\":\"wishare-applet/decoration/pattern/AppletPatternE/121711721793109/20221227/1672130921793109.png\",\"name\":\"w1.png\",\"suffix\":\"png\",\"size\":106451,\"type\":1}"}]}]

class SCHomeVisitorDecorationModel {
  SCHomeVisitorDecorationModel({
      Info? info, 
      OverallDecoration? overallDecoration, 
      List<PageDecorationList>? pageDecorationList,}){
    _info = info;
    _overallDecoration = overallDecoration;
    _pageDecorationList = pageDecorationList;
}

  SCHomeVisitorDecorationModel.fromJson(dynamic json) {
    _info = json['info'] != null ? Info.fromJson(json['info']) : null;
    _overallDecoration = json['overallDecoration'] != null ? OverallDecoration.fromJson(json['overallDecoration']) : null;
    if (json['pageDecorationList'] != null) {
      _pageDecorationList = [];
      json['pageDecorationList'].forEach((v) {
        _pageDecorationList?.add(PageDecorationList.fromJson(v));
      });
    }
  }
  Info? _info;
  OverallDecoration? _overallDecoration;
  List<PageDecorationList>? _pageDecorationList;
SCHomeVisitorDecorationModel copyWith({  Info? info,
  OverallDecoration? overallDecoration,
  List<PageDecorationList>? pageDecorationList,
}) => SCHomeVisitorDecorationModel(  info: info ?? _info,
  overallDecoration: overallDecoration ?? _overallDecoration,
  pageDecorationList: pageDecorationList ?? _pageDecorationList,
);
  Info? get info => _info;
  OverallDecoration? get overallDecoration => _overallDecoration;
  List<PageDecorationList>? get pageDecorationList => _pageDecorationList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_info != null) {
      map['info'] = _info?.toJson();
    }
    if (_overallDecoration != null) {
      map['overallDecoration'] = _overallDecoration?.toJson();
    }
    if (_pageDecorationList != null) {
      map['pageDecorationList'] = _pageDecorationList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 12171107798206
/// name : "首页"
/// sort : 0
/// componentList : [{"id":12171107799107,"patternId":12171107797803,"pageDecorationId":12171107798206,"componentId":1,"name":"轮播图","info":"{\"autoplaySpeed\":3,\"advertisementImgList\":[{\"fileKey\":\"wishare-applet/decoration/pattern/AppletPatternE/121711641905107/20221227/1672130841905107.png\",\"name\":\"s1.png\",\"suffix\":\"png\",\"size\":181515,\"type\":1},{\"fileKey\":\"wishare-applet/decoration/pattern/AppletPatternE/121711652453108/20221227/1672130852454108.png\",\"name\":\"s2.png\",\"suffix\":\"png\",\"size\":354843,\"type\":1},{\"fileKey\":\"wishare-applet/decoration/pattern/AppletPatternE/121711666228012/20221227/1672130866228112.png\",\"name\":\"s3.png\",\"suffix\":\"png\",\"size\":361888,\"type\":1}]}"}]

class PageDecorationList {
  PageDecorationList({
      int? id, 
      String? name, 
      int? sort, 
      List<ComponentList>? componentList,}){
    _id = id;
    _name = name;
    _sort = sort;
    _componentList = componentList;
}

  PageDecorationList.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _sort = json['sort'];
    if (json['componentList'] != null) {
      _componentList = [];
      json['componentList'].forEach((v) {
        _componentList?.add(ComponentList.fromJson(v));
      });
    }
  }
  int? _id;
  String? _name;
  int? _sort;
  List<ComponentList>? _componentList;
PageDecorationList copyWith({  int? id,
  String? name,
  int? sort,
  List<ComponentList>? componentList,
}) => PageDecorationList(  id: id ?? _id,
  name: name ?? _name,
  sort: sort ?? _sort,
  componentList: componentList ?? _componentList,
);
  int? get id => _id;
  String? get name => _name;
  int? get sort => _sort;
  List<ComponentList>? get componentList => _componentList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['sort'] = _sort;
    if (_componentList != null) {
      map['componentList'] = _componentList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 12171107799107
/// patternId : 12171107797803
/// pageDecorationId : 12171107798206
/// componentId : 1
/// name : "轮播图"
/// info : "{\"autoplaySpeed\":3,\"advertisementImgList\":[{\"fileKey\":\"wishare-applet/decoration/pattern/AppletPatternE/121711641905107/20221227/1672130841905107.png\",\"name\":\"s1.png\",\"suffix\":\"png\",\"size\":181515,\"type\":1},{\"fileKey\":\"wishare-applet/decoration/pattern/AppletPatternE/121711652453108/20221227/1672130852454108.png\",\"name\":\"s2.png\",\"suffix\":\"png\",\"size\":354843,\"type\":1},{\"fileKey\":\"wishare-applet/decoration/pattern/AppletPatternE/121711666228012/20221227/1672130866228112.png\",\"name\":\"s3.png\",\"suffix\":\"png\",\"size\":361888,\"type\":1}]}"

class ComponentList {
  ComponentList({
      int? id, 
      int? patternId, 
      int? pageDecorationId, 
      int? componentId, 
      String? name, 
      String? info,}){
    _id = id;
    _patternId = patternId;
    _pageDecorationId = pageDecorationId;
    _componentId = componentId;
    _name = name;
    _info = info;
}

  ComponentList.fromJson(dynamic json) {
    _id = json['id'];
    _patternId = json['patternId'];
    _pageDecorationId = json['pageDecorationId'];
    _componentId = json['componentId'];
    _name = json['name'];
    _info = json['info'];
  }
  int? _id;
  int? _patternId;
  int? _pageDecorationId;
  int? _componentId;
  String? _name;
  String? _info;
ComponentList copyWith({  int? id,
  int? patternId,
  int? pageDecorationId,
  int? componentId,
  String? name,
  String? info,
}) => ComponentList(  id: id ?? _id,
  patternId: patternId ?? _patternId,
  pageDecorationId: pageDecorationId ?? _pageDecorationId,
  componentId: componentId ?? _componentId,
  name: name ?? _name,
  info: info ?? _info,
);
  int? get id => _id;
  int? get patternId => _patternId;
  int? get pageDecorationId => _pageDecorationId;
  int? get componentId => _componentId;
  String? get name => _name;
  String? get info => _info;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['patternId'] = _patternId;
    map['pageDecorationId'] = _pageDecorationId;
    map['componentId'] = _componentId;
    map['name'] = _name;
    map['info'] = _info;
    return map;
  }

}

/// bottomNavigation : {"iconLocation":0,"navigationList":[{"id":12171107800106,"patternId":12171107797803,"title":"首页","link":12171107798206,"icon":"11893949688304","iconInfo":{"id":11893949688304,"checked":"wishare-applet/decoration/pattern/AppletPatternE/118939418628402/20221125/1669358618629102.png","unchecked":"wishare-applet/decoration/pattern/AppletPatternE/118939394376401/20221125/1669358594394101.png"},"sort":0},{"id":12171107800108,"patternId":12171107797803,"title":"我的","link":12171107798206,"icon":"11893949688304","iconInfo":{"id":11893949688304,"checked":"wishare-applet/decoration/pattern/AppletPatternE/118939418628402/20221125/1669358618629102.png","unchecked":"wishare-applet/decoration/pattern/AppletPatternE/118939394376401/20221125/1669358594394101.png"},"sort":0}]}
/// themeColor : null

class OverallDecoration {
  OverallDecoration({
      BottomNavigation? bottomNavigation, 
      dynamic themeColor,}){
    _bottomNavigation = bottomNavigation;
    _themeColor = themeColor;
}

  OverallDecoration.fromJson(dynamic json) {
    _bottomNavigation = json['bottomNavigation'] != null ? BottomNavigation.fromJson(json['bottomNavigation']) : null;
    _themeColor = json['themeColor'];
  }
  BottomNavigation? _bottomNavigation;
  dynamic _themeColor;
OverallDecoration copyWith({  BottomNavigation? bottomNavigation,
  dynamic themeColor,
}) => OverallDecoration(  bottomNavigation: bottomNavigation ?? _bottomNavigation,
  themeColor: themeColor ?? _themeColor,
);
  BottomNavigation? get bottomNavigation => _bottomNavigation;
  dynamic get themeColor => _themeColor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_bottomNavigation != null) {
      map['bottomNavigation'] = _bottomNavigation?.toJson();
    }
    map['themeColor'] = _themeColor;
    return map;
  }

}

/// iconLocation : 0
/// navigationList : [{"id":12171107800106,"patternId":12171107797803,"title":"首页","link":12171107798206,"icon":"11893949688304","iconInfo":{"id":11893949688304,"checked":"wishare-applet/decoration/pattern/AppletPatternE/118939418628402/20221125/1669358618629102.png","unchecked":"wishare-applet/decoration/pattern/AppletPatternE/118939394376401/20221125/1669358594394101.png"},"sort":0},{"id":12171107800108,"patternId":12171107797803,"title":"我的","link":12171107798206,"icon":"11893949688304","iconInfo":{"id":11893949688304,"checked":"wishare-applet/decoration/pattern/AppletPatternE/118939418628402/20221125/1669358618629102.png","unchecked":"wishare-applet/decoration/pattern/AppletPatternE/118939394376401/20221125/1669358594394101.png"},"sort":0}]

class BottomNavigation {
  BottomNavigation({
      int? iconLocation, 
      List<NavigationList>? navigationList,}){
    _iconLocation = iconLocation;
    _navigationList = navigationList;
}

  BottomNavigation.fromJson(dynamic json) {
    _iconLocation = json['iconLocation'];
    if (json['navigationList'] != null) {
      _navigationList = [];
      json['navigationList'].forEach((v) {
        _navigationList?.add(NavigationList.fromJson(v));
      });
    }
  }
  int? _iconLocation;
  List<NavigationList>? _navigationList;
BottomNavigation copyWith({  int? iconLocation,
  List<NavigationList>? navigationList,
}) => BottomNavigation(  iconLocation: iconLocation ?? _iconLocation,
  navigationList: navigationList ?? _navigationList,
);
  int? get iconLocation => _iconLocation;
  List<NavigationList>? get navigationList => _navigationList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['iconLocation'] = _iconLocation;
    if (_navigationList != null) {
      map['navigationList'] = _navigationList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 12171107800106
/// patternId : 12171107797803
/// title : "首页"
/// link : 12171107798206
/// icon : "11893949688304"
/// iconInfo : {"id":11893949688304,"checked":"wishare-applet/decoration/pattern/AppletPatternE/118939418628402/20221125/1669358618629102.png","unchecked":"wishare-applet/decoration/pattern/AppletPatternE/118939394376401/20221125/1669358594394101.png"}
/// sort : 0

class NavigationList {
  NavigationList({
      int? id, 
      int? patternId, 
      String? title, 
      int? link, 
      String? icon, 
      IconInfo? iconInfo, 
      int? sort,}){
    _id = id;
    _patternId = patternId;
    _title = title;
    _link = link;
    _icon = icon;
    _iconInfo = iconInfo;
    _sort = sort;
}

  NavigationList.fromJson(dynamic json) {
    _id = json['id'];
    _patternId = json['patternId'];
    _title = json['title'];
    _link = json['link'];
    _icon = json['icon'];
    _iconInfo = json['iconInfo'] != null ? IconInfo.fromJson(json['iconInfo']) : null;
    _sort = json['sort'];
  }
  int? _id;
  int? _patternId;
  String? _title;
  int? _link;
  String? _icon;
  IconInfo? _iconInfo;
  int? _sort;
NavigationList copyWith({  int? id,
  int? patternId,
  String? title,
  int? link,
  String? icon,
  IconInfo? iconInfo,
  int? sort,
}) => NavigationList(  id: id ?? _id,
  patternId: patternId ?? _patternId,
  title: title ?? _title,
  link: link ?? _link,
  icon: icon ?? _icon,
  iconInfo: iconInfo ?? _iconInfo,
  sort: sort ?? _sort,
);
  int? get id => _id;
  int? get patternId => _patternId;
  String? get title => _title;
  int? get link => _link;
  String? get icon => _icon;
  IconInfo? get iconInfo => _iconInfo;
  int? get sort => _sort;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['patternId'] = _patternId;
    map['title'] = _title;
    map['link'] = _link;
    map['icon'] = _icon;
    if (_iconInfo != null) {
      map['iconInfo'] = _iconInfo?.toJson();
    }
    map['sort'] = _sort;
    return map;
  }

}

/// id : 11893949688304
/// checked : "wishare-applet/decoration/pattern/AppletPatternE/118939418628402/20221125/1669358618629102.png"
/// unchecked : "wishare-applet/decoration/pattern/AppletPatternE/118939394376401/20221125/1669358594394101.png"

class IconInfo {
  IconInfo({
      int? id, 
      String? checked, 
      String? unchecked,}){
    _id = id;
    _checked = checked;
    _unchecked = unchecked;
}

  IconInfo.fromJson(dynamic json) {
    _id = json['id'];
    _checked = json['checked'];
    _unchecked = json['unchecked'];
  }
  int? _id;
  String? _checked;
  String? _unchecked;
IconInfo copyWith({  int? id,
  String? checked,
  String? unchecked,
}) => IconInfo(  id: id ?? _id,
  checked: checked ?? _checked,
  unchecked: unchecked ?? _unchecked,
);
  int? get id => _id;
  String? get checked => _checked;
  String? get unchecked => _unchecked;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['checked'] = _checked;
    map['unchecked'] = _unchecked;
    return map;
  }

}

/// id : 12171107797803
/// name : "善数游客2"
/// type : 2
/// effect : true
/// operator : "11165381959503"
/// operatorName : "寇进男"
/// gmtModify : "2022-12-27 16:50:13"

class Info {
  Info({
      int? id, 
      String? name, 
      int? type, 
      bool? effect, 
      String? operator, 
      String? operatorName, 
      String? gmtModify,}){
    _id = id;
    _name = name;
    _type = type;
    _effect = effect;
    _operator = operator;
    _operatorName = operatorName;
    _gmtModify = gmtModify;
}

  Info.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _type = json['type'];
    _effect = json['effect'];
    _operator = json['operator'];
    _operatorName = json['operatorName'];
    _gmtModify = json['gmtModify'];
  }
  int? _id;
  String? _name;
  int? _type;
  bool? _effect;
  String? _operator;
  String? _operatorName;
  String? _gmtModify;
Info copyWith({  int? id,
  String? name,
  int? type,
  bool? effect,
  String? operator,
  String? operatorName,
  String? gmtModify,
}) => Info(  id: id ?? _id,
  name: name ?? _name,
  type: type ?? _type,
  effect: effect ?? _effect,
  operator: operator ?? _operator,
  operatorName: operatorName ?? _operatorName,
  gmtModify: gmtModify ?? _gmtModify,
);
  int? get id => _id;
  String? get name => _name;
  int? get type => _type;
  bool? get effect => _effect;
  String? get operator => _operator;
  String? get operatorName => _operatorName;
  String? get gmtModify => _gmtModify;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['type'] = _type;
    map['effect'] = _effect;
    map['operator'] = _operator;
    map['operatorName'] = _operatorName;
    map['gmtModify'] = _gmtModify;
    return map;
  }

}