

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widget/business_common_widget.dart';
import '../config/images.dart';

enum ViewState{ loading, done, error}

///页面加载状态Widget，真实的内容用它包裹
class LoadingStateWidget extends StatelessWidget {

  final ViewState viewState;
  final VoidCallback? retry;
  final Widget child;  //真正要展示的Widget

  const LoadingStateWidget({Key? key,this.viewState = ViewState.loading, this.retry, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (viewState == ViewState.loading) {
      return _loadView;
    } else if (viewState == ViewState.error) {
      return _errorView;
    } else {
      return child;
    }
  }

  Widget get _loadView {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget get _errorView {
    return Center(
      child: GestureDetector(
        onTap: retry,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImagesRes.common_status_widget_ic_error,
              width: 100.w,
              height: 100.w,
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.w),
              child: Text(
                "加载错误",
                style: textStyleSecondary(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

