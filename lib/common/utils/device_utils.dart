

import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';

import 'log_utils.dart';

///设备信息工具类
class DeviceUtils{

  static String? osVersion;
  static String? model;
  static String? androidId;

  static Future<void> init() async{
    if(Platform.isAndroid){
      //Android设备信息
      var deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      osVersion = androidInfo.version.release;
      model = androidInfo.model;

      //好像不太对，正式项目建议还是自己实现Android Plugin
      androidId = await const AndroidId().getId();

      logD("DeviceInfo（设备信息）-- osVersion: $osVersion，model: $model，androidId: $androidId");
    }else if(Platform.isIOS){

    }
  }

}