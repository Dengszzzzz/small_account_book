
import 'package:flutter/material.dart';

///对于全屏的Page，标题栏应该在状态栏下方，此处提供一个状态栏的高度空间
class StatusBarHeightWidget extends StatelessWidget {
  const StatusBarHeightWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      ///状态栏高度
      height: MediaQuery.of(context).padding.top,
      width: 0,
    );
  }
}
