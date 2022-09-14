import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:smartcommunity/constants/sc_asset.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/constants/sc_fonts.dart';
import 'package:smartcommunity/page/Home/Model/sc_home_news_model.dart';

/// 首页-新闻资讯item

class SCHomeNewsItem extends StatefulWidget {

  List<SCHomeNewsModel>? newsList;

  final Function(int index)? onTap;

  SCHomeNewsItem({Key? key, required this.newsList, this.onTap}) : super(key: key);

  @override
  SCHomeNewsItemState createState() => SCHomeNewsItemState();
}

class SCHomeNewsItemState extends State<SCHomeNewsItem>
    with SingleTickerProviderStateMixin {
  List tabList = [
    '第1页',
    '第2页',
    '第3页',
    '第4页',
    '第5页',
    '第6页',
  ];

  late TabController tabController;

  /// scale
  final double scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  @override
  initState() {
    super.initState();
    tabController = TabController(length: tabList.length, vsync: this);
  }

  /// body
  Widget body(BuildContext context) {
    return Column(
      children: [
        tabBarItem(),
        gridItems(),
      ],
    );
  }

  /// tabBarItem
  Widget tabBarItem() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      height: 44.0 * scale,
      child: PreferredSize(
          preferredSize: Size.fromHeight(40.0 * scale),
          child: Material(
            color: Colors.transparent,
            child: Theme(
                data: ThemeData(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent),
                child: TabBar(
                  controller: tabController,
                  labelPadding: EdgeInsets.symmetric(horizontal: 12.0),
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: SCColors.color_FF6C00,
                  unselectedLabelColor: SCColors.color_8D8E99,
                  labelColor: SCColors.color_1B1D33,
                  indicatorWeight: 3.0,
                  labelStyle:
                      TextStyle(fontSize: SCFonts.f16 * scale, fontWeight: FontWeight.w500),
                  unselectedLabelStyle: TextStyle(
                      fontSize: SCFonts.f16 * scale, fontWeight: FontWeight.w400),
                  tabs: const [
                    Tab(
                      text: '精选资讯',
                    ),
                    Tab(
                      text: '和谐邻里',
                    ),
                    Tab(
                      text: '第三个',
                    ),
                    Tab(
                      text: '第四个',
                    ),
                    Tab(
                      text: '第五个',
                    ),
                    Tab(
                      text: '第六个',
                    )
                  ],
                )),
          )),
    );
  }

  /// 资讯网格item
  Widget gridItems() {
    int? count = widget.newsList?.length;
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: SCColors.color_F5F5F5,
      ),
      child: StaggeredGridView.countBuilder(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
          mainAxisSpacing: 16,
          crossAxisSpacing: 12,
          crossAxisCount: 2,
          shrinkWrap: true,
          itemCount: count,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            SCHomeNewsModel model = widget.newsList![index];
            return gridCellItem(model: model, index: index);
          },
          staggeredTileBuilder: (int index) {
            return const StaggeredTile.fit(1);
          }),
    );
  }

  /// 资讯-网格cellItem
  Widget gridCellItem({SCHomeNewsModel? model, required int index}) {
    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap?.call(index);
        }
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 14.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imageItem(model: model),
            SizedBox(
              height: 8.0,
            ),
            titleItem(model: model),
            SizedBox(
              height: 6.0,
            ),
            pubTimeItem(model: model)
          ],
        ),
      ),
    );
  }

  /// 图片
  Widget imageItem({SCHomeNewsModel? model}) {
    double imageWidth = model?.imageWidth ?? 331.0;
    double imageHeight = model?.imageHeight ?? 344.0;
    double imageScale = imageWidth / imageHeight;
    String imageUrl = model?.imageUrl ?? '';
    return ClipRRect(
      borderRadius: BorderRadius.circular(6.0),
      child: AspectRatio(
        aspectRatio: imageScale,
        child: Image.asset(
          imageUrl,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  /// 标题
  Widget titleItem({SCHomeNewsModel? model}) {
    String title = model?.title ?? '';
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.0),
      child: Text(
        title,
        textAlign: TextAlign.left,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: SCFonts.f14 * scale,
          color: SCColors.color_1B1D33,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// 发布时间、点赞量
  Widget pubTimeItem({SCHomeNewsModel? model}) {
    String title = model?.date ?? '';
    String iconUrl;
    String likeCount = '${model?.likeCount}';
    if (model?.likeState != null && model?.likeState == true) {
      iconUrl = SCAsset.iconNormalLike;
    } else {
      iconUrl = SCAsset.iconSelectedLike;
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.0),
      child: Row(
        children: [
          Expanded(
              child: Text(
            title,
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              fontSize: SCFonts.f12 * scale,
              color: SCColors.color_8D8E99,
              fontWeight: FontWeight.w400,
            ),
          )),
          SizedBox(
            width: 16.0,
          ),
          Row(
            children: [
              Image.asset(
                iconUrl,
                width: 14.0,
                height: 14.0,
              ),
              SizedBox(
                width: 4.0,
              ),
              Text(
                likeCount,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: SCFonts.f12 * scale,
                  color: SCColors.color_8D8E99,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
