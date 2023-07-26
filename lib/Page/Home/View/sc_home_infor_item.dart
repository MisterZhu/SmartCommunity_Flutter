import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/Home/View/sc_home_infor_image_item.dart';
import 'package:smartcommunity/Page/Home/View/sc_home_infor_unimage_item.dart';

import '../../../Constants/sc_h5.dart';
import '../../../Network/sc_config.dart';
import '../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../Utils/Router/sc_router_helper.dart';
import '../../../Utils/Router/sc_router_path.dart';
import '../GetXController/sc_home_controller2.dart';
import '../Model/sc_home_news_model.dart';

class CommunitInfoItem extends StatelessWidget {
  const CommunitInfoItem({
    Key? key,
    required this.state,
  }) : super(key: key);

  final SCHomeController2 state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding:
              const EdgeInsets.only(left: 20, top: 8, bottom: 16), // 设置左边距为24像素
          child: const Text(
            // state.inforInfo?.title ?? "",
            "社区资讯",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: SCColors.color_1B1D33),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0), // 设置四个角的圆角半径，可以根据需要调整值
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0), // 设置左右边距为 16
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: SCColors.color_FFFFFF, // 添加一个背景颜色，确保圆角效果正确显示
            ),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              // 设置padding为零
              physics: const NeverScrollableScrollPhysics(),
              // 禁用子ListView的滚动
              shrinkWrap: true,

              itemCount: state.inforList.length,
              itemBuilder: (context, index) {
                var newsItem = state.inforList[index];
                if (newsItem.frontCover != null &&
                    newsItem.frontCover!.isNotEmpty) {
                  // 有图片的样式
                  return SCHomeInforImageItem(
                    title: newsItem.title ?? "",
                    date: newsItem.gmtCreate ?? "",
                    image: newsItem.frontCover!,
                    onTap: () {
                      // 处理有图片样式的单元格点击事件
                      print('点击了有图片的资讯');
                      String token = SCScaffoldManager.instance.user.token ?? "";

                      String workOrderUrl =
                          "${SCConfig.getH5Url(SCH5.inforDetailUrl)}?id=${newsItem.id}&Authorization=$token";
                      var params = {"title": "社区资讯", "url": workOrderUrl};
                      SCRouterHelper.pathPage(SCRouterPath.webViewPath, params);
                    },
                  );
                } else {
                  // 无图片的样式
                  return SCHomeInforNoImageItem(
                    title: newsItem.title ?? "",
                    date: newsItem.gmtCreate ?? "",
                    onTap: () {
                      // 处理无图片样式的单元格点击事件
                      print('点击了无图片的资讯');
                      String token = SCScaffoldManager.instance.user.token ?? "";

                      String workOrderUrl =
                          "${SCConfig.getH5Url(SCH5.inforDetailUrl)}?id=${newsItem.id}&Authorization=$token";
                      var params = {"title": "社区资讯", "url": workOrderUrl};
                      // var params = {'title' : "社区资讯", 'url' : url,'removeLoginCheck' : true};
                      SCRouterHelper.pathPage(SCRouterPath.webViewPath, params);
                    },
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
