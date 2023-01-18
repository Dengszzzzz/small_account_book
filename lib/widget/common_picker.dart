import 'package:flustars_flutter3/flustars_flutter3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common/utils/navigator_util.dart';
import '../model/picker_info.dart';
import 'business_common_widget.dart';

///通用选择器
class CommonPicker extends StatefulWidget {
  final List<PickerInfo> mData;

  const CommonPicker({
    Key? key,
    required this.mData,
  }) : super(key: key);

  @override
  State<CommonPicker> createState() => _CommonPickerState();
}

class _CommonPickerState extends State<CommonPicker> {

  ///返回的结果，是列表的index
  PickerInfo? result;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _title(),
          _content(),
        ],
      ),
    );
  }

  _title() {
    return Container(
      height: 44.w,
      child: Row(
        children: [
          TextButton(
              onPressed: () => back(),
              child: Text(
                "取消",
                style: textStyleSecondary(fontSize: 15.sp),
              )),
          const Spacer(),
          TextButton(
              onPressed: () {
                back(result:result);
              },
              child: Text(
                "确定",
                style: textStylePrimary(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 15.sp),
              )),
        ],
      ),
    );
  }

  _content() {


    return SizedBox(
      height: 210.w,
      child: CupertinoPicker(
        // diameterRatio: 1.5,
        // offAxisFraction: 0.2, //轴偏离系数
        // useMagnifier: true, //使用放大镜
        // magnification: 1.5, //当前选中item放大倍数
        itemExtent: 45.w, //行高
        // backgroundColor: Colors.amber, //选中器背景色
        onSelectedItemChanged: (index) {
          result = widget.mData[index];
          LogUtil.d(result);
        },
        ///方式一：
        children: widget.mData.map((e) {
          return Center(
            child: Text(
              e.desc,
              style: textStylePrimary(fontSize: 15.sp),
            ),
          );
        }).toList(),
        /*children: [
          ...widget.mData.map((e) {
            return Center(
              child: Text(
                e,
                style: textStylePrimary(fontSize: 15.sp),
              ),
            );
          }).toList(),],*/
      ),
    );
  }
}
