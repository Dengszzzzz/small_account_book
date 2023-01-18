

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flustars_flutter3/flustars_flutter3.dart';
import 'package:flutter/material.dart';

import 'common/config/uri_provider.dart';
import 'common/utils/device_utils.dart';
import 'common/utils/package_info_utils.dart';

class AppInit{

  AppInit._();

  static var deviceData = <String, dynamic>{};

  ///App初始化的操作，相当于Application
  static Future<void> init() async{
    //日志打印
    LogUtil.init(tag: "DzhTest",isDebug: true,maxLen: 10000);
    //网络
    //UriProvider.init(1);
    //WebUrl.init(1);
    //本地设备信息
    //DeviceUtils.init();
    PackageInfoUtils.init();
    //SpUtil初始化，可以考虑使用 shared_preferences
    await SpUtil.getInstance();

    //模拟耗时三秒
    //await Future.delayed(const Duration(seconds: 2));
  }

}