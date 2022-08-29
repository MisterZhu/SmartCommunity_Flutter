import 'package:flutter/material.dart';

import '../../../../constants/sc_colors.dart';

/// Copyright (c), 浙江慧享信息科技有限公司
/// FileName: sc_select_house_community_page_view
/// Author: wang tao
/// Email: wangtao1@lvchengfuwu.com
/// Date: 2022/8/18 9:56
/// Description: 选择房号-幢
class SCSelectHouseBuildingPageView extends StatefulWidget {
  const SCSelectHouseBuildingPageView({Key? key}) : super(key: key);

  @override
  State<SCSelectHouseBuildingPageView> createState() =>
      _SCSelectHouseBuildingPageViewState();
}

class _SCSelectHouseBuildingPageViewState
    extends State<SCSelectHouseBuildingPageView> {
  @override
  Widget build(BuildContext context) {
    return _body();
  }

  Widget _body() {
    return Stack(
      children: [
        // 阴影
        Container(
          margin: const EdgeInsets.only(left: 16.0, right: 16.0),
          height: 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(5.0),
            color: SCColors.color_1B1C33,
          ),
        ),

        // 内容
        Container(
            margin: const EdgeInsets.only(top: 2.0, left: 16.0, right: 16.0),
            child: DecoratedBox(
              decoration: BoxDecoration(color: SCColors.color_F2F3F5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(

                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(8.0),
                      color: SCColors.color_FFFFFF,
                    ),
                    child: Column(
                      children: [
                        // 搜索框
                        Text('这是选择幢这是选择幢这是选择幢这是选择幢这是选择幢这是选择幢这是选择幢这是选择幢这是选择幢这是选择幢这是选择幢这是选择幢这是选择幢这是选择幢这是选择幢这是选择幢这是选择幢这是选择幢这是选择幢这是选择幢这是选择幢这是选择幢这是选择幢')
                      ],
                    ),
                  ),
                ],
              ),
            ))

      ],
    );
  }
}
