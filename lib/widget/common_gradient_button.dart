
import 'package:flutter/material.dart';
import '../common/config/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///通用渐变色按钮
class CommonGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final double? radius;
  final double? fontSize;
  final FontWeight? fontWeight;

  const CommonGradientButton(this.text,
      {Key? key,
        this.onPressed,
        this.width,
        this.height,
        this.fontSize,
        this.fontWeight,
        this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 310.w,
      height: height ?? 55.w,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [ColorRes.gradientStart, ColorRes.gradientEnd]),
        borderRadius: BorderRadius.circular(radius ?? 27.5.w),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          //背景颜色
          foregroundColor: MaterialStateProperty.all(Colors.white),
          //字体颜色
          // overlayColor: MaterialStateProperty.all(Colors.teal),                   //高亮色(选择颜色)
          //shadowColor: MaterialStateProperty.all(Colors.red),                      //阴影颜色
          elevation: MaterialStateProperty.all(0),
          //阴影值
          textStyle: MaterialStateProperty.all(TextStyle(
              fontWeight: fontWeight ?? FontWeight.bold,
              fontSize: fontSize ?? 19.sp)),
          //字体
          //side: MaterialStateProperty.all(BorderSide(width: 1,color: Color(0xffffffff))),//边框
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 27.5.w))), //圆角弧度
        ),
        child: Text(text),
      ),
    );
  }
}