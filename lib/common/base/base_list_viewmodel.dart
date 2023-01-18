
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../config/config.dart';
import '../http/api.dart';
import '../http/common_param_utils.dart';
import '../http/result_data.dart';
import '../utils/toast_util.dart';
import '../widget/loading_state_widget.dart';
import 'base_change_notifier.dart';

abstract class BaseListViewModel<T> extends BaseChangeNotifier {
  List<T> itemList = []; //集合数组
  int pageNum = Config.PAGE_START;
  int pageSize = Config.PAGE_NORMAL_SIZE;
  bool canLoadMore = false;

  //上拉加载/下拉刷新控制器
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  //请求数据地址
  String getUrl();

  //List<T> 实体类转换
  T getItemFromJson(Map<String, dynamic> json);

  //下拉刷新后的额外操作
  void doExtraAfterRefresh() {}
  //对ResultData的额外处理，比如不一定是从ResultData.data直接获取的List数据
  void handleExtraResultData(ResultData resultData){}
  //对请求参数额外处理，比如还需其他参数
  void handleExtraParams(Map<String, String> map){}

  ///错误重试
  void retry() {
    viewState = ViewState.loading;
    notifyListeners();
    refresh();
  }

  ///刷新
  Future<void> refresh() async {
    pageNum = Config.PAGE_START;
    ResultData resultData = await _requestData();
    handleExtraResultData(resultData);
    if (resultData.isSuccess()) {
      //数据转换
      itemList.clear();
      resultData.data.forEach((v) {
        itemList.add(getItemFromJson(v));
      });
      canLoadMore = itemList.length > pageSize;
      //控制器状态
      refreshController.refreshCompleted();
     // refreshController.footerMode?.value = LoadStatus.canLoading;
       refreshController.footerMode?.value =
          canLoadMore ? LoadStatus.canLoading : LoadStatus.noMore;
      viewState = ViewState.done;
      //额外的操作
      doExtraAfterRefresh();
    } else {
      ToastUtil.showError(resultData.message);
      refreshController.refreshFailed();
      viewState = ViewState.error;
    }
    notifyListeners();
  }

  ///加载更多
  Future<void> loadMore() async {
    pageNum++;
    ResultData resultData = await _requestData();
    handleExtraResultData(resultData);
    if (resultData.isSuccess()) {
      //数据转换
      List<T> tempList = [];
      resultData.data.forEach((v) {
        tempList.add(getItemFromJson(v));
      });
      canLoadMore = tempList.length > pageSize;
      //控制器状态
      if (tempList.isNotEmpty) {
        itemList.addAll(tempList);
        refreshController.loadComplete();
       // refreshController.footerMode?.value = LoadStatus.canLoading;
        refreshController.footerMode?.value =
            canLoadMore ? LoadStatus.canLoading : LoadStatus.noMore;
      } else {
        refreshController.loadNoData();
      }
      viewState = ViewState.done;
    } else {
      pageNum--;
      ToastUtil.showError(resultData.message);
      refreshController.loadFailed();
      viewState = ViewState.error;
    }
    notifyListeners();
  }

  ///请求列表信息
  Future<ResultData> _requestData() async {
    Map<String, String> map = await CommonParamUtils.getLoginDefaultParam();
    map["pageNum"] = pageNum.toString();
    map["pageSize"] = pageSize.toString();
    //额外处理参数
    handleExtraParams(map);
    ResultData resultData = await httpManager.get(getUrl(), map);
    return resultData;
  }
}
