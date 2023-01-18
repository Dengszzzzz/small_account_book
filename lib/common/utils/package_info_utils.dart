
import 'package:flustars_flutter3/flustars_flutter3.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'log_utils.dart';

///App安装包信息工具类
class PackageInfoUtils{

  static String? versionName;
  static String? versionCode;

  static Future<void> init() async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    versionName = packageInfo.version;
    versionCode = packageInfo.buildNumber;
    logD("PackageInfo(安装包信息) -- appName: ${packageInfo.appName}，"
        "packageName: ${packageInfo.packageName}，"
        "appVersion: ${packageInfo.version}，"
        "appCode: ${packageInfo.buildNumber}，"
        "buildSignature: ${packageInfo.buildSignature}");
  }
}