import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common/base/provider_widget.dart';
import '../common/config/colors.dart';
import '../viewmodel/main/main_tab_navigation_viewmodel.dart';

///主页底部导航栏
class MainBottomNavigationBar extends StatefulWidget {
  final PageController pageController;

  /// [pageController] 和PageView同一个控制器.
  const MainBottomNavigationBar({Key? key, required this.pageController})
      : super(key: key);

  @override
  State<MainBottomNavigationBar> createState() =>
      _MainBottomNavigationBarState();
}

class _MainBottomNavigationBarState extends State<MainBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<MainTabNavigationViewModel>(
      model: MainTabNavigationViewModel(),
      builder: (context, model, child) {
        return BottomNavigationBar(
          //当前位置
          currentIndex: model.currentIndex,
          //固定title
          type: BottomNavigationBarType.fixed,
          selectedItemColor: ColorRes.textPrimary,
          unselectedItemColor: ColorRes.textSecondary,
          items: _items(),
          onTap: (index) {
            if (model.currentIndex != index) {
              //直接跳转不带动画，自动setState
              widget.pageController.jumpToPage(index);
              model.changeBottomTabIndex(index);
            }
          },
        );
      },
    );
  }

  List<BottomNavigationBarItem> _items() {
    return [
      _bottomItem("首页", Icons.account_balance),
      _bottomItem("月度",Icons.assignment),
      _bottomItem("年度",Icons.assessment),
      _bottomItem("我的",Icons.account_circle),
    ];
  }

  _bottomItem(String title, IconData? icon) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        size: 20.w,
        color: Colors.grey,
      ),
      activeIcon: Icon(
        icon,
        size: 20.w,
        color: Colors.green,
      ),
      label: title,
    );
  }
}
