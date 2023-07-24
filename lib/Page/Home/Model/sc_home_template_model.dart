/// 首页-资讯model

// To parse this JSON data, do
//
//     final scHomeNewsModel = scHomeNewsModelFromJson(jsonString);

import 'dart:convert';

class SCHomeTemplateModel {
  String? id;
  String? name;
  String? type;
  List<String>? pageId;
  BottomNavigation? bottomNavigation;
  TopNavigation? topNavigation;
  Background? background;
  String? tenantId;
  int? state;
  String? stateName;
  List<PageDecorationList>? pageDecorationList;

  SCHomeTemplateModel(
      {this.id,
      this.name,
      this.type,
      this.pageId,
      this.bottomNavigation,
      this.topNavigation,
      this.background,
      this.tenantId,
      this.state,
      this.stateName,
      this.pageDecorationList});

  SCHomeTemplateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    pageId = json['pageId'].cast<String>();
    bottomNavigation = json['bottomNavigation'] != null
        ? new BottomNavigation.fromJson(json['bottomNavigation'])
        : null;
    topNavigation = json['topNavigation'] != null
        ? new TopNavigation.fromJson(json['topNavigation'])
        : null;
    background = json['background'] != null
        ? new Background.fromJson(json['background'])
        : null;
    tenantId = json['tenantId'];
    state = json['state'];
    stateName = json['stateName'];
    if (json['pageDecorationList'] != null) {
      pageDecorationList = <PageDecorationList>[];
      json['pageDecorationList'].forEach((v) {
        pageDecorationList!.add(new PageDecorationList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['pageId'] = this.pageId;
    if (this.bottomNavigation != null) {
      data['bottomNavigation'] = this.bottomNavigation!.toJson();
    }
    if (this.topNavigation != null) {
      data['topNavigation'] = this.topNavigation!.toJson();
    }
    if (this.background != null) {
      data['background'] = this.background!.toJson();
    }
    data['tenantId'] = this.tenantId;
    data['state'] = this.state;
    data['stateName'] = this.stateName;
    if (this.pageDecorationList != null) {
      data['pageDecorationList'] =
          this.pageDecorationList!.map((v) => v.toJson()).toList();
    }
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
  String? pageId;
  String? title;
  int? id;
  String? checked;
  String? unchecked;

  NavigationList(
      {this.pageId, this.title, this.id, this.checked, this.unchecked});

  NavigationList.fromJson(Map<String, dynamic> json) {
    pageId = json['pageId'];
    title = json['title'];
    id = json['id'];
    checked = json['checked'];
    unchecked = json['unchecked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageId'] = this.pageId;
    data['title'] = this.title;
    data['id'] = this.id;
    data['checked'] = this.checked;
    data['unchecked'] = this.unchecked;
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

class Background {
  String? fileKey;
  String? name;
  String? suffix;
  int? size;
  int? type;

  Background({this.fileKey, this.name, this.suffix, this.size, this.type});

  Background.fromJson(Map<String, dynamic> json) {
    fileKey = json['fileKey'];
    name = json['name'];
    suffix = json['suffix'];
    size = json['size'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileKey'] = this.fileKey;
    data['name'] = this.name;
    data['suffix'] = this.suffix;
    data['size'] = this.size;
    data['type'] = this.type;
    return data;
  }
}

class PageDecorationList {
  String? id;
  String? name;
  String? code;
  String? appletJumpPath;
  List<ComponentList>? componentList;

  PageDecorationList(
      {this.id, this.name, this.code, this.appletJumpPath, this.componentList});

  PageDecorationList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    appletJumpPath = json['appletJumpPath'];
    if (json['componentList'] != null) {
      componentList = <ComponentList>[];
      json['componentList'].forEach((v) {
        componentList!.add(new ComponentList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['appletJumpPath'] = this.appletJumpPath;
    if (this.componentList != null) {
      data['componentList'] =
          this.componentList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ComponentList {
  String? id;
  String? info;
  String? name;
  String? code;

  ComponentList({this.id, this.info, this.name, this.code});

  ComponentList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    info = json['info'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['info'] = this.info;
    data['name'] = this.name;
    data['code'] = this.code;
    return data;
  }
}