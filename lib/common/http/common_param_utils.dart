import 'dart:ffi';

import 'package:connectivity_plus/connectivity_plus.dart';

class CommonParamUtils {


  //获取网络类型，wifi返回2，其他返回1.
  static Future<int> getNetworkType() async{
    var connectivityResult = await Connectivity().checkConnectivity();
    if(connectivityResult == ConnectivityResult.wifi){
      return 2;
    }
    return 1;
  }

  //网络请求通用参数封装
  static Future<Map<String, String>> getDefaultParam() async{
    var param = <String, String>{};
   return param;
  /* var netType = await getNetworkType();
    var ispType = await MyFlutterPlugin.getIspType;
    var param = <String, String>{
      "os": "android",
      "osVersion": DeviceUtils.osVersion??"",
      "appid": "xchat",
      "ispType": ispType.toString(),
      "netType":netType.toString(),
      "model": DeviceUtils.model??"",
      "appVersion": PackageInfoUtils.versionName??"",
      "appCode": PackageInfoUtils.versionCode??"",
      "deviceId": DeviceUtils.androidId??"",
      "channel": "official",
    };
    param.forEach((key, value) {
      LogUtil.d("$key:$value");
    });
    return param;*/
  }


  //登录后，所有接口都要上传uid和ticket
  static Future<Map<String, String>> getLoginDefaultParam() async{
    return getDefaultParam();
   /* var param = await getDefaultParam();
    param["uid"] = loginRepository.uid;
    param["ticket"] = loginRepository.ticket;
    return param;*/
  }
}
