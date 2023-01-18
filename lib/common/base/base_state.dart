import 'package:flutter/material.dart';

import '../widget/loading_state_widget.dart';
import 'base_viewmodel.dart';
import 'provider_widget.dart';

///泛型：L -> item数据，M->实现业务的ViewModel，T-> Widget
abstract class BaseState<M extends BaseViewModel, T extends StatefulWidget>
    extends State<T> with AutomaticKeepAliveClientMixin {
  late M viewModel;
  M createViewModel();

  Widget getContentChild(M model); //子类，在build下面的逻辑放到此处。

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
              retry: model.retry,
              child: getContentChild(model));
        });
  }

  @override
  bool get wantKeepAlive => true;
}
