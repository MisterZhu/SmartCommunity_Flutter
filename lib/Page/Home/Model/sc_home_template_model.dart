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
      {id,
      name,
      type,
      pageId,
      bottomNavigation,
      topNavigation,
      background,
      tenantId,
      state,
      stateName,
      pageDecorationList});

  SCHomeTemplateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    pageId = json['pageId'].cast<String>();
    bottomNavigation = json['bottomNavigation'] != null
        ? BottomNavigation.fromJson(json['bottomNavigation'])
        : null;
    topNavigation = json['topNavigation'] != null
        ? TopNavigation.fromJson(json['topNavigation'])
        : null;
    background = json['background'] != null
        ? Background.fromJson(json['background'])
        : null;
    tenantId = json['tenantId'];
    state = json['state'];
    stateName = json['stateName'];
    if (json['pageDecorationList'] != null) {
      pageDecorationList = <PageDecorationList>[];
      json['pageDecorationList'].forEach((v) {
        pageDecorationList!.add(PageDecorationList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['pageId'] = pageId;
    if (bottomNavigation != null) {
      data['bottomNavigation'] = bottomNavigation!.toJson();
    }
    if (topNavigation != null) {
      data['topNavigation'] = topNavigation!.toJson();
    }
    if (background != null) {
      data['background'] = background!.toJson();
    }
    data['tenantId'] = tenantId;
    data['state'] = state;
    data['stateName'] = stateName;
    if (pageDecorationList != null) {
      data['pageDecorationList'] =
          pageDecorationList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BottomNavigation {
  int? iconLocation;
  List<NavigationList>? navigationList;

  BottomNavigation({iconLocation, navigationList});

  BottomNavigation.fromJson(Map<String, dynamic> json) {
    iconLocation = json['iconLocation'];
    if (json['navigationList'] != null) {
      navigationList = <NavigationList>[];
      json['navigationList'].forEach((v) {
        navigationList!.add(NavigationList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['iconLocation'] = iconLocation;
    if (navigationList != null) {
      data['navigationList'] = navigationList!.map((v) => v.toJson()).toList();
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

  NavigationList({pageId, title, id, checked, unchecked});

  NavigationList.fromJson(Map<String, dynamic> json) {
    pageId = json['pageId'];
    title = json['title'];
    id = json['id'];
    checked = json['checked'];
    unchecked = json['unchecked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pageId'] = pageId;
    data['title'] = title;
    data['id'] = id;
    data['checked'] = checked;
    data['unchecked'] = unchecked;
    return data;
  }
}

class TopNavigation {
  int? color;

  TopNavigation({color});

  TopNavigation.fromJson(Map<String, dynamic> json) {
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['color'] = color;
    return data;
  }
}

class Background {
  String? fileKey;
  String? name;
  String? suffix;
  int? size;
  int? type;

  Background({fileKey, name, suffix, size, type});

  Background.fromJson(Map<String, dynamic> json) {
    fileKey = json['fileKey'];
    name = json['name'];
    suffix = json['suffix'];
    size = json['size'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fileKey'] = fileKey;
    data['name'] = name;
    data['suffix'] = suffix;
    data['size'] = size;
    data['type'] = type;
    return data;
  }
}

class PageDecorationList {
  String? id;
  String? name;
  String? code;
  String? appletJumpPath;
  List<ComponentList>? componentList;

  PageDecorationList({id, name, code, appletJumpPath, componentList});

  PageDecorationList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    appletJumpPath = json['appletJumpPath'];
    if (json['componentList'] != null) {
      componentList = <ComponentList>[];
      json['componentList'].forEach((v) {
        componentList!.add(ComponentList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['appletJumpPath'] = appletJumpPath;
    if (componentList != null) {
      data['componentList'] = componentList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ComponentList {
  String? id;
  String? info;
  String? name;
  String? code;

  ComponentList({id, info, name, code});

  ComponentList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    // info = json['info'] != null ? CompInfo.fromJson(json['info']) : null;
    // if (json['info'] != null) {
    //   dynamic jsonData = jsonDecode(json['info']);
    //   info = CompInfo.fromJson(jsonData);
    // }
    info = json['info'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['info'] = info;
    data['name'] = name;
    data['code'] = code;
    return data;
  }
}

class InfoInfo {
  String? title;
  int? categoryId;
  int? maxCount;
  String? type;
  int? sort;

  InfoInfo({id, info, name, code, sort});

  InfoInfo.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    categoryId = json['categoryId'];
    maxCount = json['maxCount'];
    type = json['type'];
    sort = json["sort"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['categoryId'] = categoryId;
    data['maxCount'] = maxCount;
    data['type'] = type;
    data['sort'] = sort;

    return data;
  }
}
class BannerInfo {
  String? title;
  int? categoryId;
  String? maxCount;
  String? type;
  int? sort;

  BannerInfo({id, info, name, code, sort});

  BannerInfo.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    categoryId = json['categoryId'];
    maxCount = json['maxCount'];
    type = json['type'];
    sort = json["sort"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['categoryId'] = categoryId;
    data['maxCount'] = maxCount;
    data['type'] = type;
    data['sort'] = sort;

    return data;
  }
}