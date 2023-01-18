import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///3、通用外边框按钮
class CommonOutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final double? radius;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? borderSideWidth;

  const CommonOutlineButton(this.text,
      {Key? key,
        this.onPressed,
        this.width,
        this.height,
        this.fontSize,
        this.fontWeight,
        this.borderSideWidth,
        this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 310.w,
      height: height ?? 55.w,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          //前景色
          //  primary: ColorRes.gradientEnd,
          textStyle: TextStyle(
              fontWeight: fontWeight ?? FontWeight.bold,
              fontSize: fontSize ?? 19.sp),
          //圆角
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 27.5.w),
          ),
          //边框
          side: BorderSide(
            //  color: ColorRes.gradientEnd,
            width: borderSideWidth ?? 2.w,
          ),
        ),
        child: Text(text),
      ),
    );
  }
}