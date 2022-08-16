
import 'dart:convert';

import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';

class SCCommunityModel extends ISuspensionBean {
  String name;
  String? tagIndex;
  String? namePinyin;


  SCCommunityModel({
    required this.name,
    this.tagIndex,
    this.namePinyin,
  });

  SCCommunityModel.fromJson(Map<String, dynamic> json) : name = json['name'];

  Map<String, dynamic> toJson() => {
    'name': name,
//        'tagIndex': tagIndex,
//        'isShowSuspension': isShowSuspension
  };

  @override
  String getSuspensionTag() => tagIndex!;

  @override
  String toString() => json.encode(this);
}