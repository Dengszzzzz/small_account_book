
import 'package:flutter/material.dart';
import '../../common/utils/log_utils.dart';
import '../common/base/base_state.dart';
import '../common/utils/toast_util.dart';
import '../viewmodel/main_viewmodel.dart';
import '../widget/main_bottom_navigation_bar.dart';
import 'annual/annual_page.dart';
import 'home/home_page.dart';
import 'me/mine_page.dart';
import 'month/month_page.dart';

///主页
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends BaseState<MainViewModel,MainPage> {

  DateTime? lastTime;

  final PageController pageController = PageController();

  @override
  MainViewModel createViewModel() {
    return MainViewModel();
  }

  @override
  Widget getContentChild(MainViewModel model) {
    logD("-------------------- MainPage build  ----------------------  ");
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: _buildBodyWidget(),
          bottomNavigationBar: MainBottomNavigationBar(
            pageController: pageController,
          ),
        ));
  }

  Widget _buildBodyWidget(){
    return Stack(
      children: [
        PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            HomePage(),
            MonthPage(),
            AnnualPage(),
            MinePage(),
          ],
        ),
      ],
    );
  }

  Future<bool> _onWillPop() async {
    if (lastTime == null ||
        DateTime.now().difference(lastTime!) > const Duration(seconds: 2)) {
      lastTime = DateTime.now();
      ToastUtil.showTip("再按一次退出~");
      return false;
    }
    //自动出栈
    return true;
  }


}
