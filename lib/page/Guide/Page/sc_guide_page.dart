import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartcommunity/constants/sc_asset.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/constants/sc_key.dart';
import 'package:smartcommunity/utils/Router/sc_router_helper.dart';

import '../../../utils/Router/sc_router_path.dart';

/// 引导页page

class SCGuidePage extends StatefulWidget {
  @override
  SCGuideState createState() => SCGuideState();
}

class SCGuideState extends State <SCGuidePage> {
  List imageList = [SCAsset.guide1, SCAsset.guide2, SCAsset.guide3, SCAsset.guide4, SCAsset.guide5];
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: banner2(context),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  /// 点击处理
  void tapAction(BuildContext context, int index) async{
    if (index == imageList.length - 1) {
      SharedPreferences preference = await SharedPreferences.getInstance();
      preference.setBool(SCKey.isShowGuide, false);
      bool isShowPrivacy = preference.getBool(SCKey.isShowPrivacyAlert) ?? true;
      if (isShowPrivacy == true) {
        SCRouterHelper.codeOffAllPage(8000, null);
      } else {
        SCRouterHelper.codeOffAllPage(9001, {'showClose' : false});
      }
    }
  }

  Widget body(BuildContext context) {
    return PageView.builder(
      itemCount: imageList.length,
      scrollDirection: Axis.horizontal,
      reverse: false,
      controller: pageController,
      physics: const PageScrollPhysics(parent: ClampingScrollPhysics()),
      itemBuilder: ((context, index) {
        return GestureDetector(
          onTap: (){
            tapAction(context, index);
          },
          child: Image.asset(imageList[index], width: double.infinity, height: double.infinity),
        );
      }),
      onPageChanged: (index){

      },
    );
  }

  Widget banner2(BuildContext context){
    return Swiper(
      autoplay: false,
      itemCount: imageList.length,
      viewportFraction: 1.0,
      scale: 1.0,
      loop: false,
      controller: SwiperController(),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: (){
            tapAction(context, index);
          },
          child: Image.asset(imageList[index], width: double.infinity, height: double.infinity),
        );
      },
    );
  }
}