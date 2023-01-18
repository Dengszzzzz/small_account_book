import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common/config/images.dart';
import '../common/utils/navigator_util.dart';

///全局通用AppBar
///@param showBack 是否显示返回键
///@param actions  右侧Widget
///@param bottom   标题栏底部的Widget，例如在标题栏下发设置tabBar
/// http://www.soiiy.com/flutter/6025473.html 参考
AppBar appBar(String title,
    {bool showBack = true,
    List<Widget>? actions,
    PreferredSizeWidget? bottom,
    VoidCallback? onPressed}) {
  return AppBar(
    //明暗模式：light
    //systemOverlayStyle: const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
    //标题：居中
    centerTitle: true,
    //阴影高度：0
    elevation: 0,
    //背景色：白色
    backgroundColor: Colors.white,
    //导航栏最左侧Widget：是否显示返回按钮,BackButton封装了返回操作，当ios和Android平台返回键样式不一样
    // leading: showBack? const BackButton(color: Colors.black,):null,
    leading: showBack ? BackButton(onPressed: onPressed,) : null,
    //导航栏右侧List<Widget>
    actions: actions,
    //title文字和样式
    title: Text(
      title,
      style: TextStyle(
        fontSize: 18.sp,
       // color: ColorRes.textPrimary,
        fontWeight: FontWeight.bold,
      ),
    ),
    //高度
    toolbarHeight:44.w,
    //FixMe: 解决滚动是AppBar变色问题(https://stackoverflow.com/questions/72379271/flutter-material3-disable-appbar-color-change-on-scroll)
    //有其他组件在AppBar下面滚动时用到，不设置会appbar会变色,Material Design3会变色
    scrolledUnderElevation: 0.0,
    //AppBar下面的PreferredSizeWidget ，一般应用场景是 TabBar
    bottom: bottom,
  );
}

///BackButton无法自定义Icon
myBackButton(BuildContext context, VoidCallback? onPressed) {
  return IconButton(
      onPressed: onPressed ??
          () {
            //如果onPressed不为空，说明有独立的业务要处理，否则统一返回
            back();
           // Navigator.of(context).pop();
          },
      icon: Icon(
        Icons.arrow_back,
        size: 22.w,
        color: Colors.black,
      ));
}
