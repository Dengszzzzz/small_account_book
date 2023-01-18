
import '../../common/base/base_change_notifier.dart';

class MainTabNavigationViewModel extends BaseChangeNotifier{
  int currentIndex = 0;

  void changeBottomTabIndex(int index){
    currentIndex = index;
    notifyListeners();
  }
}