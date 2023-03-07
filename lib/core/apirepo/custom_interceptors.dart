import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../di/injection_container.dart';

class CustomInterceptors extends InterceptorsWrapper {
  Logger? logger = sl();

  CustomInterceptors();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    logger!.log(Level.verbose,
        "REQUEST[${options.method}] => PATH: ${options.path} => PARAM: ${options.data}");
    logger!.log(Level.verbose,
        "QUERY PARAM: ${options.queryParameters} => EXTRA: ${options.extra}");
    logger!.log(Level.verbose, "HEADERS: ${options.headers}");
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger!.log(Level.verbose,
        "RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path} => PARAM: ${response.data}");
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    logger!.log(Level.error,
        "ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}");
    return super.onError(err, handler);
  }
}
