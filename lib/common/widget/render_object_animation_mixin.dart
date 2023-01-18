import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';

///动画调度抽象 RenderObjectAnimationMixin
mixin RenderObjectAnimationMixin on RenderObject {
  // 动画当前进度
  double _progress = 0;

  // 上一次绘制的时间
  int? _lastTimeStamp;

  // 动画时长，子类可以重写
  Duration get duration => const Duration(milliseconds: 200);

  //动画当前状态
  AnimationStatus _animationStatus = AnimationStatus.completed;

  // 设置动画状态
  set animationStatus(AnimationStatus v) {
    if (_animationStatus != v) {
      markNeedsPaint();
    }
    _animationStatus = v;
  }

  double get progress => _progress;

  set progress(double v) {
    _progress = v.clamp(0, 1);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    doPaint(context, offset); // 调用子类绘制逻辑
    _scheduleAnimation();
  }

  void _scheduleAnimation() {
    if (_animationStatus != AnimationStatus.completed) {
      // 需要在Flutter 当前frame 结束之前再执行，因为不能在绘制过程中又将组件标记为需要重绘
      SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
        if (_lastTimeStamp != null) {
          double delta = (timeStamp.inMilliseconds - _lastTimeStamp!) /
              duration.inMilliseconds;

          //在特定情况下，可能在一帧中连续的往frameCallback中添加了多次，导致两次回调时间间隔为0，
          //这种情况下应该继续请求重绘。
          if (delta == 0) {
            markNeedsPaint();
            return;
          }

          // 如果是反向动画，则 progress值要逐渐减小
          if (_animationStatus == AnimationStatus.reverse) {
            delta = -delta;
          }
          //更新动画进度
          _progress = _progress + delta;
          if (_progress >= 1 || _progress <= 0) {
            //动画执行结束
            _animationStatus = AnimationStatus.completed;
            _progress = _progress.clamp(0, 1);
          }
        }
        //标记为需要重绘
        markNeedsPaint();
        _lastTimeStamp = timeStamp.inMilliseconds;
      });
    } else {
      _lastTimeStamp = null;
    }
  }

  // 子类实现绘制逻辑的地方
  void doPaint(PaintingContext context, Offset offset);
}
