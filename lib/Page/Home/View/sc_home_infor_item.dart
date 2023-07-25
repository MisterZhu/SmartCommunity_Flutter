import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/Home/View/sc_home_infor_image_item.dart';
import 'package:smartcommunity/Page/Home/View/sc_home_infor_unimage_item.dart';

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

          child: ListView.builder(
            padding: EdgeInsets.zero, // 设置padding为零
            physics: const NeverScrollableScrollPhysics(), // 禁用子ListView的滚动
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
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
