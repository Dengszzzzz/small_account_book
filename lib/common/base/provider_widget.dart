
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderWidget<T extends ChangeNotifier> extends StatefulWidget {

  final T model;  //数据源(被观察者)
  final Widget? child;

  final Widget Function(BuildContext context,T model,Widget? child) builder;  //消费回调，数据源改变时执行这个builder
  final Function(T)? onModelInit;   //数据初始化方法

  const ProviderWidget(
      {Key? key,
        required this.model,
        required this.builder,
        this.onModelInit,
        this.child})
      : super(key: key);

  @override
  State<ProviderWidget> createState() => _ProviderWidgetState<T>();
}

class _ProviderWidgetState<T extends ChangeNotifier> extends State<ProviderWidget<T>> {

  T? model;

  @override
  void initState() {
    super.initState();
    model = widget.model;
    if(widget.onModelInit !=null && model!=null){
      widget.onModelInit!(model!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(_) => model,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}
