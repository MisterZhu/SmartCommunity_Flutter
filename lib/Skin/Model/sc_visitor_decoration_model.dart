/// info : {"id":12299963227003,"name":"善数生活-游客样式","type":2,"effect":true,"operator":"11165381959503","operatorName":"寇进男","gmtModify":"2023-01-11 14:34:19"}
/// overallDecoration : {"bottomNavigation":{"iconLocation":1,"navigationList":[{"id":12299963228905,"patternId":12299963227003,"title":"首页","link":12299963227405,"pageTemplate":{"id":1,"name":"善数-首页","appletJumpPath":"/pages/homePage/homePage"},"icon":"12299768530201","iconInfo":{"id":12299768530201,"checked":"wishare-applet/decoration/pattern/AppletPatternE/122997653030601/20230111/1673416853047101.svg","unchecked":"wishare-applet/decoration/pattern/AppletPatternE/122997627208502/20230111/1673416827209102.svg"},"sort":0},{"id":12299963228906,"patternId":12299963227003,"title":"我的","link":12299963227406,"pageTemplate":{"id":2,"name":"善数-我的","appletJumpPath":"/pages/myPage/myPage"},"icon":"12299995321203","iconInfo":{"id":12299995321203,"checked":"wishare-applet/decoration/pattern/AppletPatternE/122998229580503/20230111/1673417429580103.svg","unchecked":"wishare-applet/decoration/pattern/AppletPatternE/122998210612602/20230111/1673417410612102.svg"},"sort":0}]},"themeColor":"{\"primaryColor\":\"#FF6C00\",\"primaryColor2\":\"rgba(255, 108, 0, 0.1)\"}"}
/// pageDecorationList : [{"id":12299963227405,"pageTemplateId":1,"name":"首页","sort":0,"componentList":[{"id":12299963228109,"patternId":12299963227003,"pageDecorationId":12299963227405,"componentId":1,"name":"轮播图","info":"{\"autoplaySpeed\":3,\"advertisementImgList\":[{\"fileKey\":\"wishare-applet/decoration/pattern/AppletPatternE/122998313141603/20230111/1673417513141103.png\",\"name\":\"s1.png\",\"suffix\":\"png\",\"size\":126784,\"type\":1},{\"fileKey\":\"wishare-applet/decoration/pattern/AppletPatternE/122998321044604/20230111/1673417521044104.png\",\"name\":\"s2.png\",\"suffix\":\"png\",\"size\":340880,\"type\":1},{\"fileKey\":\"wishare-applet/decoration/pattern/AppletPatternE/122998336210605/20230111/1673417536210105.png\",\"name\":\"s3.png\",\"suffix\":\"png\",\"size\":314743,\"type\":1}]}"},{"id":12299963228110,"patternId":12299963227003,"pageDecorationId":12299963227405,"componentId":2,"name":"左滑卡片","info":"{\"componentTitle\":\"精选名宿\",\"showContent\":[3,4],\"showRule\":2}"},{"id":12299963228111,"patternId":12299963227003,"pageDecorationId":12299963227405,"componentId":3,"name":"tab卡片","info":"[{\"tabTitle\":\"亲子游\",\"tabFile\":{\"fileKey\":\"wishare-applet/decoration/pattern/AppletPatternE/118938711390301/20221125/1669357911404101.png\",\"name\":\"人员管理.png\",\"suffix\":\"png\",\"size\":2694,\"type\":1},\"showContent\":3,\"showRule\":1},{\"tabTitle\":\"情侣游\",\"tabFile\":{\"fileKey\":\"wishare-applet/decoration/pattern/AppletPatternE/118938715535302/20221125/1669357915535102.png\",\"name\":\"Group 心.png\",\"suffix\":\"png\",\"size\":2740,\"type\":1},\"showContent\":3,\"showRule\":1},{\"tabTitle\":\"主题三\",\"tabFile\":{\"fileKey\":\"wishare-applet/decoration/pattern/AppletPatternE/118938487156204/20221125/1669357687156104.png\",\"name\":\"Group 心.png\",\"suffix\":\"png\",\"size\":2740,\"type\":1},\"showContent\":6,\"showRule\":1},{\"tabTitle\":\"主题4\",\"tabFile\":{\"fileKey\":\"wishare-applet/decoration/pattern/AppletPatternE/119026130969101/20221126/1669445330986101.png\",\"name\":\"Group 427319041.png\",\"suffix\":\"png\",\"size\":2614,\"type\":1},\"showContent\":\"119265587977106\",\"showRule\":1}]"}]},{"id":12299963227406,"pageTemplateId":2,"name":"我的","sort":0,"componentList":[{"id":12299963228112,"patternId":12299963227003,"pageDecorationId":12299963227406,"componentId":4,"name":"背景图","info":"{\"fileKey\":\"wishare-applet/decoration/pattern/AppletPatternE/122999159683507/20230111/1673418359684107.png\",\"name\":\"w1.png\",\"suffix\":\"png\",\"size\":104887,\"type\":1}"}]}]

class SCVisitorDecorationModel {
  SCVisitorDecorationModel({
      Info? info, 
      OverallDecoration? overallDecoration, 
      List<PageDecorationList>? pageDecorationList,}){
    _info = info;
    _overallDecoration = overallDecoration;
    _pageDecorationList = pageDecorationList;
}

  SCVisitorDecorationModel.fromJson(dynamic json) {
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
  SCVisitorDecorationModel copyWith({  Info? info,
  OverallDecoration? overallDecoration,
  List<PageDecorationList>? pageDecorationList,
}) => SCVisitorDecorationModel(  info: info ?? _info,
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

/// id : 12299963227405
/// pageTemplateId : 1
/// name : "首页"
/// sort : 0
/// componentList : [{"id":12299963228109,"patternId":12299963227003,"pageDecorationId":12299963227405,"componentId":1,"name":"轮播图","info":"{\"autoplaySpeed\":3,\"advertisementImgList\":[{\"fileKey\":\"wishare-applet/decoration/pattern/AppletPatternE/122998313141603/20230111/1673417513141103.png\",\"name\":\"s1.png\",\"suffix\":\"png\",\"size\":126784,\"type\":1},{\"fileKey\":\"wishare-applet/decoration/pattern/AppletPatternE/122998321044604/20230111/1673417521044104.png\",\"name\":\"s2.png\",\"suffix\":\"png\",\"size\":340880,\"type\":1},{\"fileKey\":\"wishare-applet/decoration/pattern/AppletPatternE/122998336210605/20230111/1673417536210105.png\",\"name\":\"s3.png\",\"suffix\":\"png\",\"size\":314743,\"type\":1}]}"},{"id":12299963228110,"patternId":12299963227003,"pageDecorationId":12299963227405,"componentId":2,"name":"左滑卡片","info":"{\"componentTitle\":\"精选名宿\",\"showContent\":[3,4],\"showRule\":2}"},{"id":12299963228111,"patternId":12299963227003,"pageDecorationId":12299963227405,"componentId":3,"name":"tab卡片","info":"[{\"tabTitle\":\"亲子游\",\"tabFile\":{\"fileKey\":\"wishare-applet/decoration/pattern/AppletPatternE/118938711390301/20221125/1669357911404101.png\",\"name\":\"人员管理.png\",\"suffix\":\"png\",\"size\":2694,\"type\":1},\"showContent\":3,\"showRule\":1},{\"tabTitle\":\"情侣游\",\"tabFile\":{\"fileKey\":\"wishare-applet/decoration/pattern/AppletPatternE/118938715535302/20221125/1669357915535102.png\",\"name\":\"Group 心.png\",\"suffix\":\"png\",\"size\":2740,\"type\":1},\"showContent\":3,\"showRule\":1},{\"tabTitle\":\"主题三\",\"tabFile\":{\"fileKey\":\"wishare-applet/decoration/pattern/AppletPatternE/118938487156204/20221125/1669357687156104.png\",\"name\":\"Group 心.png\",\"suffix\":\"png\",\"size\":2740,\"type\":1},\"showContent\":6,\"showRule\":1},{\"tabTitle\":\"主题4\",\"tabFile\":{\"fileKey\":\"wishare-applet/decoration/pattern/AppletPatternE/119026130969101/20221126/1669445330986101.png\",\"name\":\"Group 427319041.png\",\"suffix\":\"png\",\"size\":2614,\"type\":1},\"showContent\":\"119265587977106\",\"showRule\":1}]"}]

class PageDecorationList {
  PageDecorationList({
      int? id, 
      int? pageTemplateId, 
      String? name, 
      int? sort, 
      List<ComponentList>? componentList,}){
    _id = id;
    _pageTemplateId = pageTemplateId;
    _name = name;
    _sort = sort;
    _componentList = componentList;
}

  PageDecorationList.fromJson(dynamic json) {
    _id = json['id'];
    _pageTemplateId = json['pageTemplateId'];
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
  int? _pageTemplateId;
  String? _name;
  int? _sort;
  List<ComponentList>? _componentList;
PageDecorationList copyWith({  int? id,
  int? pageTemplateId,
  String? name,
  int? sort,
  List<ComponentList>? componentList,
}) => PageDecorationList(  id: id ?? _id,
  pageTemplateId: pageTemplateId ?? _pageTemplateId,
  name: name ?? _name,
  sort: sort ?? _sort,
  componentList: componentList ?? _componentList,
);
  int? get id => _id;
  int? get pageTemplateId => _pageTemplateId;
  String? get name => _name;
  int? get sort => _sort;
  List<ComponentList>? get componentList => _componentList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['pageTemplateId'] = _pageTemplateId;
    map['name'] = _name;
    map['sort'] = _sort;
    if (_componentList != null) {
      map['componentList'] = _componentList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 12299963228109
/// patternId : 12299963227003
/// pageDecorationId : 12299963227405
/// componentId : 1
/// name : "轮播图"
/// info : "{\"autoplaySpeed\":3,\"advertisementImgList\":[{\"fileKey\":\"wishare-applet/decoration/pattern/AppletPatternE/122998313141603/20230111/1673417513141103.png\",\"name\":\"s1.png\",\"suffix\":\"png\",\"size\":126784,\"type\":1},{\"fileKey\":\"wishare-applet/decoration/pattern/AppletPatternE/122998321044604/20230111/1673417521044104.png\",\"name\":\"s2.png\",\"suffix\":\"png\",\"size\":340880,\"type\":1},{\"fileKey\":\"wishare-applet/decoration/pattern/AppletPatternE/122998336210605/20230111/1673417536210105.png\",\"name\":\"s3.png\",\"suffix\":\"png\",\"size\":314743,\"type\":1}]}"

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

/// bottomNavigation : {"iconLocation":1,"navigationList":[{"id":12299963228905,"patternId":12299963227003,"title":"首页","link":12299963227405,"pageTemplate":{"id":1,"name":"善数-首页","appletJumpPath":"/pages/homePage/homePage"},"icon":"12299768530201","iconInfo":{"id":12299768530201,"checked":"wishare-applet/decoration/pattern/AppletPatternE/122997653030601/20230111/1673416853047101.svg","unchecked":"wishare-applet/decoration/pattern/AppletPatternE/122997627208502/20230111/1673416827209102.svg"},"sort":0},{"id":12299963228906,"patternId":12299963227003,"title":"我的","link":12299963227406,"pageTemplate":{"id":2,"name":"善数-我的","appletJumpPath":"/pages/myPage/myPage"},"icon":"12299995321203","iconInfo":{"id":12299995321203,"checked":"wishare-applet/decoration/pattern/AppletPatternE/122998229580503/20230111/1673417429580103.svg","unchecked":"wishare-applet/decoration/pattern/AppletPatternE/122998210612602/20230111/1673417410612102.svg"},"sort":0}]}
/// themeColor : "{\"primaryColor\":\"#FF6C00\",\"primaryColor2\":\"rgba(255, 108, 0, 0.1)\"}"

class OverallDecoration {
  OverallDecoration({
      BottomNavigation? bottomNavigation, 
      String? themeColor,}){
    _bottomNavigation = bottomNavigation;
    _themeColor = themeColor;
}

  OverallDecoration.fromJson(dynamic json) {
    _bottomNavigation = json['bottomNavigation'] != null ? BottomNavigation.fromJson(json['bottomNavigation']) : null;
    _themeColor = json['themeColor'];
  }
  BottomNavigation? _bottomNavigation;
  String? _themeColor;
OverallDecoration copyWith({  BottomNavigation? bottomNavigation,
  String? themeColor,
}) => OverallDecoration(  bottomNavigation: bottomNavigation ?? _bottomNavigation,
  themeColor: themeColor ?? _themeColor,
);
  BottomNavigation? get bottomNavigation => _bottomNavigation;
  String? get themeColor => _themeColor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_bottomNavigation != null) {
      map['bottomNavigation'] = _bottomNavigation?.toJson();
    }
    map['themeColor'] = _themeColor;
    return map;
  }

}

/// iconLocation : 1
/// navigationList : [{"id":12299963228905,"patternId":12299963227003,"title":"首页","link":12299963227405,"pageTemplate":{"id":1,"name":"善数-首页","appletJumpPath":"/pages/homePage/homePage"},"icon":"12299768530201","iconInfo":{"id":12299768530201,"checked":"wishare-applet/decoration/pattern/AppletPatternE/122997653030601/20230111/1673416853047101.svg","unchecked":"wishare-applet/decoration/pattern/AppletPatternE/122997627208502/20230111/1673416827209102.svg"},"sort":0},{"id":12299963228906,"patternId":12299963227003,"title":"我的","link":12299963227406,"pageTemplate":{"id":2,"name":"善数-我的","appletJumpPath":"/pages/myPage/myPage"},"icon":"12299995321203","iconInfo":{"id":12299995321203,"checked":"wishare-applet/decoration/pattern/AppletPatternE/122998229580503/20230111/1673417429580103.svg","unchecked":"wishare-applet/decoration/pattern/AppletPatternE/122998210612602/20230111/1673417410612102.svg"},"sort":0}]

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

/// id : 12299963228905
/// patternId : 12299963227003
/// title : "首页"
/// link : 12299963227405
/// pageTemplate : {"id":1,"name":"善数-首页","appletJumpPath":"/pages/homePage/homePage"}
/// icon : "12299768530201"
/// iconInfo : {"id":12299768530201,"checked":"wishare-applet/decoration/pattern/AppletPatternE/122997653030601/20230111/1673416853047101.svg","unchecked":"wishare-applet/decoration/pattern/AppletPatternE/122997627208502/20230111/1673416827209102.svg"}
/// sort : 0

class NavigationList {
  NavigationList({
      int? id, 
      int? patternId, 
      String? title, 
      int? link, 
      PageTemplate? pageTemplate, 
      String? icon, 
      IconInfo? iconInfo, 
      int? sort,}){
    _id = id;
    _patternId = patternId;
    _title = title;
    _link = link;
    _pageTemplate = pageTemplate;
    _icon = icon;
    _iconInfo = iconInfo;
    _sort = sort;
}

  NavigationList.fromJson(dynamic json) {
    _id = json['id'];
    _patternId = json['patternId'];
    _title = json['title'];
    _link = json['link'];
    _pageTemplate = json['pageTemplate'] != null ? PageTemplate.fromJson(json['pageTemplate']) : null;
    _icon = json['icon'];
    _iconInfo = json['iconInfo'] != null ? IconInfo.fromJson(json['iconInfo']) : null;
    _sort = json['sort'];
  }
  int? _id;
  int? _patternId;
  String? _title;
  int? _link;
  PageTemplate? _pageTemplate;
  String? _icon;
  IconInfo? _iconInfo;
  int? _sort;
NavigationList copyWith({  int? id,
  int? patternId,
  String? title,
  int? link,
  PageTemplate? pageTemplate,
  String? icon,
  IconInfo? iconInfo,
  int? sort,
}) => NavigationList(  id: id ?? _id,
  patternId: patternId ?? _patternId,
  title: title ?? _title,
  link: link ?? _link,
  pageTemplate: pageTemplate ?? _pageTemplate,
  icon: icon ?? _icon,
  iconInfo: iconInfo ?? _iconInfo,
  sort: sort ?? _sort,
);
  int? get id => _id;
  int? get patternId => _patternId;
  String? get title => _title;
  int? get link => _link;
  PageTemplate? get pageTemplate => _pageTemplate;
  String? get icon => _icon;
  IconInfo? get iconInfo => _iconInfo;
  int? get sort => _sort;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['patternId'] = _patternId;
    map['title'] = _title;
    map['link'] = _link;
    if (_pageTemplate != null) {
      map['pageTemplate'] = _pageTemplate?.toJson();
    }
    map['icon'] = _icon;
    if (_iconInfo != null) {
      map['iconInfo'] = _iconInfo?.toJson();
    }
    map['sort'] = _sort;
    return map;
  }

}

/// id : 12299768530201
/// checked : "wishare-applet/decoration/pattern/AppletPatternE/122997653030601/20230111/1673416853047101.svg"
/// unchecked : "wishare-applet/decoration/pattern/AppletPatternE/122997627208502/20230111/1673416827209102.svg"

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

/// id : 1
/// name : "善数-首页"
/// appletJumpPath : "/pages/homePage/homePage"

class PageTemplate {
  PageTemplate({
      int? id, 
      String? name, 
      String? appletJumpPath,}){
    _id = id;
    _name = name;
    _appletJumpPath = appletJumpPath;
}

  PageTemplate.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _appletJumpPath = json['appletJumpPath'];
  }
  int? _id;
  String? _name;
  String? _appletJumpPath;
PageTemplate copyWith({  int? id,
  String? name,
  String? appletJumpPath,
}) => PageTemplate(  id: id ?? _id,
  name: name ?? _name,
  appletJumpPath: appletJumpPath ?? _appletJumpPath,
);
  int? get id => _id;
  String? get name => _name;
  String? get appletJumpPath => _appletJumpPath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['appletJumpPath'] = _appletJumpPath;
    return map;
  }

}

/// id : 12299963227003
/// name : "善数生活-游客样式"
/// type : 2
/// effect : true
/// operator : "11165381959503"
/// operatorName : "寇进男"
/// gmtModify : "2023-01-11 14:34:19"

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