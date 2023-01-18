import 'package:extended_image/extended_image.dart';
import 'package:flustars_flutter3/flustars_flutter3.dart';
import 'package:flutter/material.dart';

import '../config/images.dart';

class ImageUtils{

  ///全局统一加载头像
  static Widget avatarImage(String? url,
      {double? width,
        double? height,
        //放大填满空间，超出显示部分裁剪，和Android - centerCrop 类似
        fit = BoxFit.cover,
        BorderRadius? borderRadius,
        //设置默认圆角
        BoxShape shape = BoxShape.circle,
        //图片从 tree 中移除，清掉内存缓存，以减少内存压力
        bool clearMemoryCacheWhenDispose = false}) {
    if (ObjectUtil.isNotEmpty(url)) {
      return ExtendedImage.network(
        url!,
        shape: shape,
        height: height,
        width: width,
        fit: fit,
        borderRadius: borderRadius,
        clearMemoryCacheWhenDispose: clearMemoryCacheWhenDispose,
        loadStateChanged: (state) {
          if (state.extendedImageLoadState == LoadState.failed) {
            return defaultAvatarImage(width: width);
          }
          return null;
        },
      );
    }
    return defaultAvatarImage(width: width);
  }

  ///默认头像
  static Widget defaultAvatarImage({double? width}) {
    return ClipOval(
      child: Image.asset(
        ImagesRes.common_ic_default_avatar,
        width: width,
        fit: BoxFit.cover,
      ),
    );
  }
}

