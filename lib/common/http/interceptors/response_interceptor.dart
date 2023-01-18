import 'package:dio/dio.dart';

/// Response 拦截器
/// 比如要解密的时候
class ResponseInterceptors extends InterceptorsWrapper {

  @override
  onResponse(Response response, handler) async {
    RequestOptions option = response.requestOptions;
  /*  var value;
    try {
      var header = response.headers[Headers.contentTypeHeader];
      if ((header != null && header.toString().contains("text"))) {
        value = new ResultData(response.data, true, Code.SUCCESS);
      } else if (response.statusCode! >= 200 && response.statusCode! < 300) {
        value = new ResultData(response.data, true, Code.SUCCESS,
            headers: response.headers);
      }
    } catch (e) {
      print(e.toString() + option.path);
      value = new ResultData(response.data, false, response.statusCode,
          headers: response.headers);
    }
    response.data = value;*/
    return handler.next(response);
  }
}
