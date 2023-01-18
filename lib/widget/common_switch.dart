
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/config/colors.dart';

///4、通用Switch
class CommonSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  const CommonSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // CupertinoSwitch 无法通过Container设置大小，要改变大小，可采用以下方案
    return Transform.scale(
      scale: 0.8,
      child: CupertinoSwitch(
        value: value,
        onChanged: onChanged,
        //激活颜色（已选中背景）
        activeColor: ColorRes.gradientEnd,
        //拇指颜色 (圆形滑块)
        thumbColor: Colors.white,
        //轨迹颜色（未选中背景）
        // trackColor: Colors.greenAccent,
      ),
    );
  }
}