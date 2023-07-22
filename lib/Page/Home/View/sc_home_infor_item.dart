


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
            '社区资讯', // 替换为您的标题内容
            style: TextStyle(
              fontSize: 16, 
              fontWeight: FontWeight.w500,
              color: SCColors.color_1B1D33),
          ),
        ),
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
          child: Container(
            height: 4,
            decoration: const BoxDecoration(
              color: SCColors.color_FFFFFF,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4.0),
                topRight: Radius.circular(4.0),
              ),
            ),
            margin: const EdgeInsets.only(left: 16.0, right: 16.0),
          ),
        ),
        ListView.builder(
          padding: EdgeInsets.zero, // 设置padding为零
          physics: const NeverScrollableScrollPhysics(), // 禁用子ListView的滚动
          shrinkWrap: true,

          itemCount: state.allNewsList?.length,
          itemBuilder: (context, index) {
            SCHomeNewsModel newsItem = state.allNewsList![index];
            if (newsItem.imageUrl != null && newsItem.imageUrl!.isNotEmpty) {
              // 有图片的样式
              return SCHomeInforImageItem(
                title: newsItem.title ?? "",
                date: newsItem.date ?? "",
                image: newsItem.imageUrl!,
                onTap: () {
                  // 处理有图片样式的单元格点击事件
                  print('点击了有图片的资讯');
                },
              );
            } else {
              // 无图片的样式
              return SCHomeInforNoImageItem(
                title: newsItem.title ?? "",
                date: newsItem.date ?? "",
                onTap: () {
                  // 处理无图片样式的单元格点击事件
                  print('点击了无图片的资讯');
                },
              );
            }
          },
        ),
      ],
    );
  }
}