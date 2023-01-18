import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

import '../code.dart';
import '../result_data.dart';

/// Response 拦截器
/// 比如要加密的时候
class RequestInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    //没有网络
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return handler.reject(DioError(
          requestOptions: options,
          type: DioErrorType.other,
          response: Response(
            requestOptions: options,
            data: ResultData(Code.NETWORK_ERROR,
                Code.errorHandleFunction(Code.NETWORK_ERROR, "没有网络~"), null),
          )));
    }
    super.onRequest(options, handler);
  }
}
