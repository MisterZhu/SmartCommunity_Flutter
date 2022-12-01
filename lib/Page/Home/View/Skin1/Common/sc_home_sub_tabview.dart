import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:smartcommunity/Page/Home/Model/sc_home_news_model.dart';
import 'package:smartcommunity/Page/Home/View/Skin1/Data/sc_home_news_repository.dart';
import 'package:smartcommunity/Page/Home/View/Skin1/Common/sc_home_loadmore_footer.dart';

import '../../../../../Constants/sc_asset.dart';
import '../../../../../Constants/sc_colors.dart';
import '../../../../../Constants/sc_fonts.dart';

/// 首页第一套皮肤TabView的子widget
class SCHomeSubTabView extends StatefulWidget {
  const SCHomeSubTabView(this.repository);

  final SCHomeNewsRespority? repository;

  @override
  SCHomeSubTabViewState createState() => SCHomeSubTabViewState();
}

class SCHomeSubTabViewState extends State<SCHomeSubTabView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 6.0),
      child: LoadingMoreCustomScrollView(
        showGlowLeading: false,
        physics: const ClampingScrollPhysics(),
        slivers: <Widget>[
          LoadingMoreSliverList<SCHomeNewsModel>(
              SliverListConfig<SCHomeNewsModel>(
            lastChildLayoutType: LastChildLayoutType.foot,
            itemBuilder: itemBuilder,
            indicatorBuilder: indicatorBuilder,
            sourceList: widget.repository!,
            extendedListDelegate:
                const SliverWaterfallFlowDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              crossAxisSpacing: 12,
              mainAxisSpacing: 16,
            ),
            //isLastOne: false
          ))
        ],
      ),
    );
  }

  /// item
  Widget itemBuilder(BuildContext context, SCHomeNewsModel item, int index) {
    return gridCellItem(model: item, index: index);
  }

  /// indicator
  Widget indicatorBuilder(BuildContext context, IndicatorStatus status) {
    return SCHomeLoadMoreFooter(status: status, isSliver: true,);
  }

  /// 资讯-网格cellItem
  Widget gridCellItem({SCHomeNewsModel? model, required int index}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.only(bottom: 14.0),
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
            const SizedBox(
              height: 8.0,
            ),
            titleItem(model: model),
            const SizedBox(
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
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Text(
        title,
        textAlign: TextAlign.left,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: SCFonts.f14,
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
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Row(
        children: [
          Expanded(
              child: Text(
            title,
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              fontSize: SCFonts.f12,
              color: SCColors.color_8D8E99,
              fontWeight: FontWeight.w400,
            ),
          )),
          const SizedBox(
            width: 16.0,
          ),
          Row(
            children: [
              Image.asset(
                iconUrl,
                width: 14.0,
                height: 14.0,
              ),
              const SizedBox(
                width: 4.0,
              ),
              Text(
                likeCount,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: SCFonts.f12,
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

  @override
  bool get wantKeepAlive => true;
}
