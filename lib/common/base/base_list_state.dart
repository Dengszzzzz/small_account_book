import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../widget/loading_state_widget.dart';
import 'base_list_viewmodel.dart';
import 'provider_widget.dart';

abstract class BaseListState<L, M extends BaseListViewModel<L>,
        T extends StatefulWidget> extends State<T>
    with AutomaticKeepAliveClientMixin {

  late M viewModel;
  M createViewModel();
  Widget getContentChild(M model); //子类，在build下面的逻辑放到此处。

  bool enablePullUp = true;
  bool enablePullDown = true;

  ///提供做初始化操作，比如修改 enablePullUp 的值等
  init() {}

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<M>(
        model: createViewModel(),
        onModelInit: (model){
          viewModel = model;
          model.refresh();
        },
        builder: (context, model, child) {
          return LoadingStateWidget(
            viewState: model.viewState,
            ///Fixme：model.retry() 会造成 setState() or markNeedsBuild() called during build.
            ///  model.retry:  直接用，不加括号，就是这个方法本身结构传过去，而不是其运算后的返回值
            ///  model.retry():  这样相当于调用方法后得到的值，这个方法返回类型是什么，就是一个什么类型的值。
            ///  所以用model.retry() 时，不停地在执行  notifyListeners()。
            ///  最安全处理方式是 方法都指定返回类型
            retry: model.retry,
            child: Container(
              child: SmartRefresher(
                controller: model.refreshController,
                onRefresh: model.refresh,
                onLoading: model.loadMore,
                enablePullUp: enablePullUp,
                enablePullDown: enablePullDown,
                //显示的界面
                child: getContentChild(model),

                //最好全局配置RefreshConfiguration
                /*header: WaterDropHeader(),
                footer: CustomFooter(
                  builder: (context,mode){
                    Widget body ;
                    if(mode==LoadStatus.idle){
                      body = Text("上拉加载");
                    }
                    else if(mode==LoadStatus.loading){
                      body = CupertinoActivityIndicator();
                    }
                    else if(mode == LoadStatus.failed){
                      body = Text("加载失败！点击重试！");
                    }
                    else if(mode == LoadStatus.canLoading){
                      body = Text("松手,加载更多!");
                    }
                    else{
                      body = Text("没有更多数据了!");
                    }
                    return Container(
                      height: 55.0,
                      child: Center(child:body),
                    );
                  },
                ),*/
              ),
            ),
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
