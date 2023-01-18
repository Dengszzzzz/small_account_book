
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common/config/colors.dart';

///二级TabBar
///可选参数的默认值必须是常量，所以不能在 fontSize 设置 20.sp
TabBar secondLevelTabBar({
  TabController? controller,
  required List<Widget> tabs,
  ValueChanged<int>? onTap,
  double? fontSize,
  double? unselectedFontSize,
  //当前选中颜色
  Color labelColor = ColorRes.textPrimary,
  //未选中标签字体颜色
  Color unselectedLabelColor = ColorRes.textSecondary,
  //下划线颜色
  Color indicatorColor = ColorRes.textPrimary,
  // 下划线的大小
  TabBarIndicatorSize indicatorSize = TabBarIndicatorSize.label,
}){

  return TabBar(
    //是否可滑动
    isScrollable: true,
    controller: controller,
    tabs: tabs,
    onTap: onTap,
    labelColor: labelColor,
    unselectedLabelColor: unselectedLabelColor,
    labelStyle: TextStyle(fontSize: fontSize ?? 20.sp),
    unselectedLabelStyle: TextStyle(fontSize: unselectedFontSize ?? 15.sp),
    indicatorColor: indicatorColor,
    indicatorSize: indicatorSize,
  );

}