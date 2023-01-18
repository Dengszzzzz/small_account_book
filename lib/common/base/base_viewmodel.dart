

import '../widget/loading_state_widget.dart';
import 'base_change_notifier.dart';

abstract class BaseViewModel extends BaseChangeNotifier{

  void refresh(){}
  void loadMore(){}

  void retry(){
    viewState = ViewState.loading;
    notifyListeners();
    refresh();
  }

}