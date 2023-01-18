
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'render_object_animation_mixin.dart';

///https://book.flutterchina.club/chapter10/custom_checkbox.html#_10-6-1-customcheckbox
///自定义CheckBox，原生的无法设置大小和圆角
class CustomCheckbox extends LeafRenderObjectWidget{

  const CustomCheckbox({
    Key? key,
    this.strokeWidth = 2.0,
    this.value = false,
    this.strokeColor = Colors.white,
    this.fillColor = Colors.blue,
    this.radius = 2.0,
    this.onChanged,
  }) : super(key: key);

  final double strokeWidth; // “勾”的线条宽度
  final Color strokeColor; // “勾”的线条宽度
  final Color? fillColor; // 填充颜色
  final bool value; //选中状态
  final double radius; // 圆角
  final ValueChanged<bool>? onChanged; // 选中状态发生改变后的回调

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCustomCheckbox(
      strokeWidth,
      strokeColor,
      fillColor ?? Theme.of(context).primaryColor,
      value,
      radius,
      onChanged,
    );
  }

  @override
  void updateRenderObject(BuildContext context, covariant RenderCustomCheckbox renderObject) {
    //当选中状态发生变化时，我们要更新RenderObject中的动画状态，具体逻辑是：
    // 当从未选中切换为选中状态时，执行正向动画；当从选中状态切换为未选中状态时执行反向动画。
    if (renderObject.value != value) {
      renderObject.animationStatus =
      value ? AnimationStatus.forward : AnimationStatus.reverse;
    }
    renderObject
      ..strokeWidth = strokeWidth
      ..strokeColor = strokeColor
      ..fillColor = fillColor ?? Theme.of(context).primaryColor
      ..radius = radius
      ..value = value
      ..onChanged = onChanged;
  }

}

/// with 混入，伪多继承，直接使用 RenderObjectAnimationMixin的方法和属性，而不需要 super.xx
class RenderCustomCheckbox extends RenderBox with RenderObjectAnimationMixin{

  bool value;
  int pointerId = -1;
  double strokeWidth;
  Color strokeColor;
  Color fillColor;
  double radius;
  ValueChanged<bool>? onChanged;

  RenderCustomCheckbox(this.strokeWidth, this.strokeColor, this.fillColor,
      this.value, this.radius, this.onChanged) {
    progress = value ? 1 : 0;
  }

  @override
  bool get isRepaintBoundary => true;

  //背景动画时长占比（背景动画要在前40%的时间内执行完毕，之后执行打勾动画）
  final double bgAnimationInterval = .4;

  @override
  void doPaint(PaintingContext context, Offset offset) {
    Rect rect = offset & size;
    _drawBackground(context, rect);
    _drawCheckMark(context, rect);
  }

  void _drawBackground(PaintingContext context, Rect rect) {
    Color color = value ? fillColor : Colors.grey;
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill //填充
      ..strokeWidth
      ..color = color;

    // 我们需要算出每一帧里面矩形的大小，为此我们可以直接根据矩形插值方法来确定里面矩形
    final outer = RRect.fromRectXY(rect, radius, radius);
    // 根据动画执行进度调整来确定里面矩形在每一帧的大小
    var rects = [
      rect.inflate(-strokeWidth),
      Rect.fromCenter(center: rect.center, width: 0, height: 0)
    ];
    var rectProgress = Rect.lerp(
      rects[0],
      rects[1],
      // 背景动画的执行时长是前 40% 的时间
      min(progress, bgAnimationInterval) / bgAnimationInterval,
    )!;
    final inner = RRect.fromRectXY(rectProgress, 0, 0);
    // 画背景
    context.canvas.drawDRRect(outer, inner, paint);
  }

  //画 "勾"
  void _drawCheckMark(PaintingContext context, Rect rect) {
    // 在画好背景后再画前景
    if (progress > bgAnimationInterval) {

      //确定中间拐点位置
      final secondOffset = Offset(
        rect.left + rect.width / 2.5,
        rect.bottom - rect.height / 4,
      );
      // 第三个点的位置
      final lastOffset = Offset(
        rect.right - rect.width / 6,
        rect.top + rect.height / 4,
      );

      // 我们只对第三个点的位置做插值
      final _lastOffset = Offset.lerp(
        secondOffset,
        lastOffset,
        (progress - bgAnimationInterval) / (1 - bgAnimationInterval),
      )!;

      // 将三个点连起来
      final path = Path()
        ..moveTo(rect.left + rect.width / 7, rect.top + rect.height / 2)
        ..lineTo(secondOffset.dx, secondOffset.dy)
        ..lineTo(_lastOffset.dx, _lastOffset.dy);

      final paint = Paint()
        ..isAntiAlias = true
        ..style = PaintingStyle.stroke
        ..color = strokeColor
        ..strokeWidth = strokeWidth;

      context.canvas.drawPath(path, paint..style = PaintingStyle.stroke);
    }
  }

  ///实现布局算法,如果父组件指定了固定宽高，则使用父组件指定的，否则宽高默认置为 25
  @override
  void performLayout() {
    size = constraints.constrain(
      constraints.isTight ? Size.infinite : const Size(25, 25),
    );
  }

  ///要让渲染对象能处理事件，则它必须能通过命中测试，之后才能在 handleEvent 方法中处理事件
  // 必须置为true，否则不可以响应事件
  @override
  bool hitTestSelf(Offset position) => true;

  // 只有通过点击测试的组件才会调用本方法
  @override
  void handleEvent(PointerEvent event, covariant BoxHitTestEntry entry) {
    if (event.down) {
      pointerId = event.pointer;
    } else if (pointerId == event.pointer) {
      // 判断手指抬起时是在组件范围内的话才触发onChange
      if(size.contains(event.localPosition)) {
        onChanged?.call(!value);
      }
    }
  }
}