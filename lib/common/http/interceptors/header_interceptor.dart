import 'package:dio/dio.dart';
import 'package:flustars_flutter3/flustars_flutter3.dart';

import '../../config/config.dart';
import '../sign_utils.dart';


/// header拦截器
class HeaderInterceptors extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options, handler) async {
    ///超时
    options.connectTimeout = 30000;
    options.receiveTimeout = 30000;
    ///请求头
    options.headers = _getSignHeader(options.path, null, options.queryParameters);
    return super.onRequest(options, handler);
  }

  ///每次请求都重新配置请求头，需要验证
  _getSignHeader(
      String url, Map<String, String>? header, Map<String, dynamic> params) {
    //如果header为null，则new一个Map给headers
    Map<String, String?> headers = header ?? {};
    //时间戳
    var time = DateUtil.getNowDateMs().toString();
    var sign = SignUtils.getSign(url, params, Config.desKey, time);
    headers["t"] = time;
    headers["sn"] = sign;
    return headers;
  }
}
