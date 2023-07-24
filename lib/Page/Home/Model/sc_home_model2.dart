/// 首页-资讯model

// To parse this JSON data, do
//
//     final scHomeNewsModel = scHomeNewsModelFromJson(jsonString);

import 'dart:convert';

class SCHomeModel2 {
  Background? background;
  BottomNavigation? bottomNavigation;
  String? id;
  String? name;
  List<PageDecorationList>? pageDecorationList;
  int? state;
  String? stateName;
  String? tenantId;
  TopNavigation? topNavigation;
  String? type;

  SCHomeModel2(
      {this.background,
        this.bottomNavigation,
        this.id,
        this.name,
        this.pageDecorationList,
        this.state,
        this.stateName,
        this.tenantId,
        this.topNavigation,
        this.type});

  SCHomeModel2.fromJson(Map<String, dynamic> json) {
    background = json['background'] != null
        ? new Background.fromJson(json['background'])
        : null;
    bottomNavigation = json['bottomNavigation'] != null
        ? new BottomNavigation.fromJson(json['bottomNavigation'])
        : null;
    id = json['id'];
    name = json['name'];
    if (json['pageDecorationList'] != null) {
      pageDecorationList = <PageDecorationList>[];
      json['pageDecorationList'].forEach((v) {
        pageDecorationList!.add(new PageDecorationList.fromJson(v));
      });
    }

    state = json['state'];
    stateName = json['stateName'];
    tenantId = json['tenantId'];
    topNavigation = json['topNavigation'] != null
        ? new TopNavigation.fromJson(json['topNavigation'])
        : null;
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.background != null) {
      data['background'] = this.background!.toJson();
    }
    if (this.bottomNavigation != null) {
      data['bottomNavigation'] = this.bottomNavigation!.toJson();
    }
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.pageDecorationList != null) {
      data['pageDecorationList'] =
          this.pageDecorationList!.map((v) => v.toJson()).toList();
    }
   
    data['state'] = this.state;
    data['stateName'] = this.stateName;
    data['tenantId'] = this.tenantId;
    if (this.topNavigation != null) {
      data['topNavigation'] = this.topNavigation!.toJson();
    }
    data['type'] = this.type;
    return data;
  }
}

class Background {
  String? fileKey;
  String? name;
  int? size;
  String? suffix;
  int? type;

  Background({this.fileKey, this.name, this.size, this.suffix, this.type});

  Background.fromJson(Map<String, dynamic> json) {
    fileKey = json['fileKey'];
    name = json['name'];
    size = json['size'];
    suffix = json['suffix'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileKey'] = this.fileKey;
    data['name'] = this.name;
    data['size'] = this.size;
    data['suffix'] = this.suffix;
    data['type'] = this.type;
    return data;
  }
}

class BottomNavigation {
  int? iconLocation;
  List<NavigationList>? navigationList;

  BottomNavigation({this.iconLocation, this.navigationList});

  BottomNavigation.fromJson(Map<String, dynamic> json) {
    iconLocation = json['iconLocation'];
    if (json['navigationList'] != null) {
      navigationList = <NavigationList>[];
      json['navigationList'].forEach((v) {
        navigationList!.add(new NavigationList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iconLocation'] = this.iconLocation;
    if (this.navigationList != null) {
      data['navigationList'] =
          this.navigationList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NavigationList {
  String? checked;
  int? id;
  String? pageId;
  String? title;
  String? unchecked;

  NavigationList(
      {this.checked, this.id, this.pageId, this.title, this.unchecked});

  NavigationList.fromJson(Map<String, dynamic> json) {
    checked = json['checked'];
    id = json['id'];
    pageId = json['pageId'];
    title = json['title'];
    unchecked = json['unchecked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['checked'] = this.checked;
    data['id'] = this.id;
    data['pageId'] = this.pageId;
    data['title'] = this.title;
    data['unchecked'] = this.unchecked;
    return data;
  }
}

class PageDecorationList {
  String? appletJumpPath;
  String? code;
  List<ComponentList>? componentList;
  String? id;
  String? name;

  PageDecorationList(
      {this.appletJumpPath, this.code, this.componentList, this.id, this.name});

  PageDecorationList.fromJson(Map<String, dynamic> json) {
    appletJumpPath = json['appletJumpPath'];
    code = json['code'];
    if (json['componentList'] != null) {
      componentList = <ComponentList>[];
      json['componentList'].forEach((v) {
        componentList!.add(new ComponentList.fromJson(v));
      });
    }
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appletJumpPath'] = this.appletJumpPath;
    data['code'] = this.code;
    if (this.componentList != null) {
      data['componentList'] =
          this.componentList!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class ComponentList {
  String? code;
  String? id;
  String? info;
  String? name;

  ComponentList({this.code, this.id, this.info, this.name});

  ComponentList.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    id = json['id'];
    info = json['info'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['id'] = this.id;
    data['info'] = this.info;
    data['name'] = this.name;
    return data;
  }
}

class TopNavigation {
  int? color;

  TopNavigation({this.color});

  TopNavigation.fromJson(Map<String, dynamic> json) {
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color'] = this.color;
    return data;
  }
}