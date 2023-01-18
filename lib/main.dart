import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:small_account_book/page.dart';

import 'app_init.dart';
import 'common/config/colors.dart';
import 'common/utils/log_utils.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
  //Flutter沉浸式状态栏，Platform.isAndroid 判断是否是Android手机
  if (Platform.isAndroid) {
    // setSystemUIOverlayStyle:用来设置状态栏顶部和底部样式
    // https://www.cnblogs.com/ofg233/p/14227285.html
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AppInit.init(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            logD("初始化完成，移除 FlutterNativeSplash");
            FlutterNativeSplash.remove();
            return const GetMaterialAppWidget();
          }
          return const CircularProgressIndicator();
        });
  }
}


class GetMaterialAppWidget extends StatefulWidget {
  const GetMaterialAppWidget({Key? key}) : super(key: key);

  @override
  State<GetMaterialAppWidget> createState() => _GetMaterialAppWidgetState();
}

class _GetMaterialAppWidgetState extends State<GetMaterialAppWidget> {
  @override
  Widget build(BuildContext context) {
    return _screenUtilInit(
      child: _refreshConfiguration(
        child: GetMaterialApp(
          ///初始化路由，引用启动后跳转的第一个页面，优先级 initialRoute > home
          //home: CompleteUserInfoPage(),
          // initialRoute: '/loginType',
          initialRoute: '/main',
          getPages: pages,
          theme: _themeData(),
        ),
      ),
    );
  }

  /// 1、ScreenUtilInit 屏幕适配
  Widget _screenUtilInit({required Widget child}) {
    return ScreenUtilInit(
      /// 设计图尺寸
      designSize: const Size(375, 667),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) {
        return child;
      },
    );
  }

  /// 2、PullToRefresh 全局配置
  Widget _refreshConfiguration({required Widget child}) {
    return RefreshConfiguration(
      headerBuilder: () => const WaterDropHeader(),
      // 配置默认头部指示器,假如你每个页面的头部指示器都一样的话,你需要设置这个
      footerBuilder: () => const ClassicFooter(),
      // 配置默认底部指示器
      headerTriggerDistance: 80.0,
      // 头部触发刷新的越界距离
      springDescription:
      const SpringDescription(stiffness: 170, damping: 16, mass: 1.9),
      // 自定义回弹动画,三个属性值意义请查询flutter api
      maxOverScrollExtent: 100,
      //头部最大可以拖动的范围,如果发生冲出视图范围区域,请设置这个属性
      maxUnderScrollExtent: 0,
      // 底部最大可以拖动的范围
      enableScrollWhenRefreshCompleted: true,
      //这个属性不兼容PageView和TabBarView,如果你特别需要TabBarView左右滑动,你需要把它设置为true
      enableLoadingWhenFailed: true,
      //在加载失败的状态下,用户仍然可以通过手势上拉来触发加载更多
      hideFooterWhenNotFull: false,
      // Viewport不满一屏时,禁用上拉加载更多功能
      enableBallisticLoad: true,
      // 可以通过惯性滑动触发加载更多
      child: child,
    );
  }

  ///theme 样式
  ///参考：https://www.jianshu.com/p/2f4b5119d770
  _themeData() {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.green,
      useMaterial3: true,

      ///一些控件的颜色及样式，公共样式在这里配置
      //scaffold背景色
      scaffoldBackgroundColor: Colors.white,
      //Divider和PopupMenuDivider的颜色，也用于ListTile之间、DataTable的行之间等
      dividerColor: ColorRes.divider,
      /* textTheme: TextTheme(
        //大标题(AppBar使用)
        titleLarge: TextStyle(fontSize: 19.sp),
        titleMedium: TextStyle(fontSize: )
      ),*/
      //BottomAppBar的默认颜色
      //bottomAppBarColor: Colors.white,
      // Card的颜色(比如选中文本显示的操作弹窗)
      // cardColor: ColorRes.gradientEnd,
      //获得焦点时颜色
      //  focusColor: ColorRes.textPrimary,
      //InkWell使用,墨水飞溅的颜色
      //splashColor:Colors.red
      //定义由InkWell和InkResponse反应产生的墨溅的外观,下面这句取消水波纹
      //splashFactory:NoSplash.splashFactory,
      // 用于突出显示选定行的颜色
      //selectedRowColor:Colors.red,
      // 用于处于非活动(但已启用)状态的小部件的颜色
      // 例如，未选中的复选框
      // 通常与accentColor形成对比，也看到disabledColor
      // unselectedWidgetColor: Colors.black12,
      // 禁用状态下部件的颜色，无论其当前状态如何
      // 例如，一个禁用的复选框（可以选中或未选中）
      // disabledColor: Colors.black12,
      // 定义按钮部件的默认配置，如RaisedButton和FlatButton
      //buttonTheme:ButtonThemeData(),
      //文本框选中文本样式
      /* textSelectionTheme: TextSelectionThemeData(
        //文本框中光标的颜色
        cursorColor: ColorRes.textPrimary,
        //文本框中文本选择的颜色，如TextField
        selectionColor: ColorRes.gradientEnd,
        //用于调整当前选定的文本部分的句柄的颜色(比如复制时的开始和结束句柄)
        selectionHandleColor: ColorRes.textPrimary,
      ),*/
      // 用于提示文本或占位符文本的颜色
      // 例如在TextField中
      hintColor: ColorRes.textSecondary,
      // 与主色形成对比的颜色
      // 例如用作进度条的剩余部分
      // backgroundColor: Colors.black12,
      //Dialog 元素的背景颜色
      // dialogBackgroundColor:Colors.green,
      //选项卡中选定的选项卡指示器的颜色
      /*indicatorColor: Colors.pink,
      tabBarTheme: const TabBarTheme(
          labelColor:ColorRes.textPrimary,
          unselectedLabelColor:ColorRes.textSecondary,
      ),*/
      // InputDecorator、TextField和TextFormField的默认InputDecoration值
      /*inputDecorationTheme: InputDecorationTheme(
        fillColor: ColorRes.textFieldFillColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10.w),
        ),
      ),*/
      // 用于自定义选项卡栏指示器的大小、形状和颜色的主题
      //tabBarTheme:,
      //用于自定义Appbar的颜色、高度、亮度、iconTheme和textTheme的主题
      // appBarTheme:,
      // 自定义BottomAppBar的形状、高度和颜色的主题
      // bottomAppBarTheme:,
      // 拥有13种颜色，可用于配置大多数组件的颜色
      //  colorScheme:,
      //自定义Dialog的主题形状
      // dialogTheme:,
      //// 底部滑出对话框的主题样式
      // bottomSheetTheme:,
      // Divider组件（横向线条组件）的主题样式
      // dividerTheme:,
      //BottomNavigationBar（底部导航栏）的主题样式
      // bottomNavigationBarTheme:,
      // Checkbox的主题样式
      //  checkboxTheme:,
      // Radio的主题样式
      //  radioTheme:,
      // Switch的主题样式
      //  switchTheme:,
    );
  }
}