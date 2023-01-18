import 'package:flustars_flutter3/flustars_flutter3.dart';
import 'package:flutter/material.dart';

import '../utils/log_utils.dart';

///图片选择框(有问题，别用，只做参考用)
///来源：https://blog.csdn.net/aplixy/article/details/106042184
class ImageRadio extends StatefulWidget {
  ///是否选中
  bool isSelected;

  ///
  VoidCallback? callMe;

  ///图片Url
  final String imageUrl;
  final ImageRadioController controller;
  final ValueChanged<bool> onChange;

  ///控件高度
  final double width;
  final double height;

  ///图片宽高
  final double imageWidth;
  final double imageHeight;

  ///选中颜色
  final Color activeBorderColor;

  ///未选中颜色
  final Color inactiveBorderColor;

  ///选中框-宽度
  final double activeBorderWidth;

  ///未选中框-宽度
  final double inactiveBorderWidth;

  ///角度
  final double borderRadius;

  ImageRadio(this.imageUrl,
      {Key? key,
      this.isSelected = false,
      required this.controller,
      required this.onChange,
      this.width = 80.0,
      this.height = 80.0,
      this.imageWidth = 70.0,
      this.imageHeight = 70.0,
      this.activeBorderColor = Colors.red,
      this.inactiveBorderColor = Colors.transparent,
      this.activeBorderWidth = 3.0,
      this.inactiveBorderWidth = 3.0,
      this.borderRadius = 2.0})
      : super(key: key);

  @override
  State<ImageRadio> createState() => _ImageRadioState();
}

class _ImageRadioState extends State<ImageRadio> {

  late VoidCallback makeMeUnselect;

  @override
  void initState() {
    // init
    makeMeUnselect = () {
      setState(() {
        widget.isSelected = false;
      });
      widget.onChange(false);
    };
    // backup
    widget.callMe = makeMeUnselect;
    // add
    widget.controller.add(makeMeUnselect);
    super.initState();
  }

  @override
  void dispose() {
    logD("dispose() remove callback--->$makeMeUnselect");
    widget.controller.remove(makeMeUnselect);
    super.dispose();
  }

  ///这里多次setState{}后，出现这个异常，暂时注释掉这段代码
  ///The _ScaffoldLayout custom multichild layout delegate forgot to lay out the following child:
  ///
  /// oldWidget.callMe != makeMeUnselect 有点奇怪。
  @override
  void didUpdateWidget(ImageRadio oldWidget) {
    /*logD("didUpdateWidget() remove--->${oldWidget.key}");
    if (oldWidget != widget && oldWidget.callMe != makeMeUnselect) {
      widget.controller.remove(oldWidget.callMe!);
      widget.controller.add(makeMeUnselect);
      logD("didUpdateWidget() remove--->$makeMeUnselect");
      logD("didUpdateWidget() add--->$makeMeUnselect");
    }*/
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.isSelected = true;
        });
        widget.onChange(true);
        widget.controller.unselectOthers(makeMeUnselect);
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
              width: widget.isSelected
                  ? widget.activeBorderWidth
                  : widget.inactiveBorderWidth,
              color: widget.isSelected
                  ? widget.activeBorderColor
                  : widget.inactiveBorderColor),
          borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
        ),
        child: Image.asset(
          widget.imageUrl,
          fit: BoxFit.cover,
          width: widget.imageWidth,
          height: widget.imageHeight,
        ),
      ),
    );
  }
}

class ImageRadioController {
  List<VoidCallback>? _callbackList;

  ImageRadioController() {
    _callbackList = [];
  }

  void add(VoidCallback callback) {
    _callbackList ??= [];
    _callbackList?.add(callback);
  }

  void remove(VoidCallback callback) {
    _callbackList?.remove(callback);
  }

  void dispose() {
    _callbackList?.clear();
    _callbackList = null;
  }

  void unselectOthers(VoidCallback currentCallback) {
    if (_callbackList?.isNotEmpty == true) {
      for (int i = 0, len = _callbackList!.length; i < len; i++) {
        VoidCallback callback = _callbackList![i];
        if (callback == currentCallback) continue;
        callback();
      }
    }
  }
}
