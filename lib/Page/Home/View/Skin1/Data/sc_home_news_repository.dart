
import 'package:get/get.dart';
import 'package:loading_more_list/loading_more_list.dart';

import '../../../GetXController/sc_home_controller1.dart';
import '../../../Model/sc_home_news_model.dart';

class SCHomeNewsRespority extends LoadingMoreBase <SCHomeNewsModel> {
  SCHomeNewsRespority({this.maxLength = 300});
  int _pageIndex = 1;
  bool _hasMore = true;
  bool forceRefresh = false;

  @override
  bool get hasMore => (_hasMore && length < maxLength) || forceRefresh;
  final int maxLength;

  @override
  Future<bool> refresh([bool notifyStateChanged = false]) async {
    _hasMore = true;
    _pageIndex = 1;
    //force to refresh list when you don't want clear list before request
    //for the case, if your list already has 20 items.
    forceRefresh = !notifyStateChanged;
    final bool result = await super.refresh(notifyStateChanged);
    forceRefresh = false;
    return result;
  }

  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    return Future<bool>.delayed(const Duration(seconds: 3), () {
      if (_pageIndex == 1) {
        clear();
      }

      SCHomeController1 state = Get.find<SCHomeController1>();
      List<SCHomeNewsModel> list = state.allNewsList ?? [];
      for(SCHomeNewsModel model in list) {
        add(model);
      }
      _hasMore = true;
      _pageIndex++;
     return true;
    });
  }
}