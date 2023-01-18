

import 'package:flutter/foundation.dart';

import '../widget/loading_state_widget.dart';


class BaseChangeNotifier extends ChangeNotifier{
  ViewState viewState = ViewState.loading;
  bool _dispose = false;

  @override
  void dispose() {
    super.dispose();
    _dispose = true;
  }

  @override
  void notifyListeners() {
    if(!_dispose){
      super.notifyListeners();
    }
  }

}