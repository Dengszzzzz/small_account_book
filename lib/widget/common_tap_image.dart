
import 'package:flutter/material.dart';

///通用可点击Image.asset
class TapImageAsset extends StatelessWidget {
  final String url;
  final GestureTapCallback onTap;
  final double? width;
  final double? height;

  const TapImageAsset(
      {Key? key,
        required this.url,
        required this.onTap,
        this.width,
        this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        url,
        width: width,
        height: height,
      ),
    );
  }
}