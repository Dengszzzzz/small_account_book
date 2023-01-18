import 'package:dio/dio.dart';

import 'code.dart';
import 'interceptors/header_interceptor.dart';
import 'interceptors/request_interceptor.dart';
import 'interceptors/response_interceptor.dart';
import 'result_data.dart';

///http请求
class HttpManager {
  final Dio _dio = Dio(); //使用默认配置

  HttpManager() {
    //添加拦截器(注意顺序)
    _dio.interceptors.add(HeaderInterceptors());
    _dio.interceptors.add(LogInterceptor(
      requestHeader: false,
      responseHeader: false,
      requestBody: true,
      responseBody: true,
    ));
    _dio.interceptors.add(RequestInterceptors());
    _dio.interceptors.add(ResponseInterceptors());
  }

  ///get请求
  Future<ResultData> get(String url, Map<String, String> params) async {
    //参数加密
    //fixme:todo....
    Response response;
    try {
      //指定Response<ResultData>类型
      response = await _dio.get(url, queryParameters: params);
    } on DioError catch (e) {
      //这里是捕获DioError类型的异常
      return _resultError(e, url);
    }
    //走到这说明网络请求无问题
    //将Response转为ResultData,
    return ResultData.fromJson(response.data);
  }

  ///Post请求
  Future<ResultData> post(String url, Map<String, String> params) async {
    //参数加密
    //fixme:todo....
    Response response;
    try {
      response = await _dio.post(url, queryParameters: params);
    } on DioError catch (e) {
      return _resultError(e, url);
    }
    return ResultData.fromJson(response.data);
  }

  ///错误统一处理
  ResultData _resultError(DioError e, String url) {
    Response? errorResponse;
    if (e.response != null) {
      errorResponse = e.response;
    } else {
      errorResponse =
          Response(statusCode: 666, requestOptions: RequestOptions(path: url));
    }
    //如果是读写超时或连接超时的错误
    if (e.type == DioErrorType.connectTimeout ||
        e.type == DioErrorType.receiveTimeout) {
      errorResponse!.statusCode = Code.NETWORK_TIMEOUT;
    }
    return ResultData(errorResponse!.statusCode!,
        Code.errorHandleFunction(errorResponse.statusCode, e.message), null);
  }
}

final HttpManager httpManager = HttpManager();
