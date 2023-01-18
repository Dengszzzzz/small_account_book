import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common/config/colors.dart';
import '../common/config/images.dart';

//将common dart文件集中导出，避免别的页面导入太多
export 'common_gradient_button.dart';
export 'common_outline_button.dart';
export 'common_picker.dart';
export 'common_switch.dart';
export 'common_tap_image.dart';
export 'app_bar.dart';
export 'tab_bar.dart';

//业务公共用到的Widget，统一样式等

///某些页面的置顶渐变色，可以选择 widget或使用函数，使用函数无法用const，当父widget build时，都会去加载，因此此处选择自定义widget
/*class PageTopBgWidget extends StatelessWidget {
  const PageTopBgWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(ImagesRes.main_main_top_bg, width: double.infinity);
  }
}*/

///页面加载
Widget showPageLoading(){
  return Container(
    width: double.infinity,
    height: double.infinity,
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}

///页面空视图
Widget showEmptyView(){
  return Container(
    width: double.infinity,
    height: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(ImagesRes.common_ic_content_empty,width: 146.w,height: 115.w,),
        Text("暂无数据",style: textStyleSecondary(fontSize: 14.sp))
      ],
    ),
  );
}

///通用文字样式，默认一级颜色、15sp、不加粗
TextStyle textStylePrimary({Color? color, double? fontSize, FontWeight? fontWeight}) {
  return TextStyle(
    color: color ?? ColorRes.textPrimary,
    fontSize: fontSize ?? 15.sp,
    fontWeight: fontWeight,
  );
}

///通用文字样式，默认二级颜色、15sp、不加粗
TextStyle textStyleSecondary({Color? color, double? fontSize, FontWeight? fontWeight}) {
  return TextStyle(
    color: color ?? ColorRes.textSecondary,
    fontSize: fontSize ?? 15.sp,
    fontWeight: fontWeight,
  );
}

///通用文字样式，默认二级颜色、15sp、不加粗
TextStyle textStyleWhite({Color? color, double? fontSize, FontWeight? fontWeight}) {
  return TextStyle(
    color: color ?? Colors.white,
    fontSize: fontSize ?? 15.sp,
    fontWeight: fontWeight,
  );
}

