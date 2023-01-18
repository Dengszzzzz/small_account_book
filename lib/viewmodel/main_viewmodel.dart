
import 'package:flustars_flutter3/flustars_flutter3.dart';
import 'package:get/get.dart';

import '../common/base/base_viewmodel.dart';
import '../common/widget/loading_state_widget.dart';
import '../repository/main_repository.dart';

class MainViewModel extends BaseViewModel{

  final MainRepository _mainRepository = MainRepository();

  @override
  void refresh() {
    viewState = ViewState.done;
    notifyListeners();
  }

}