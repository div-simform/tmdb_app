import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CustomInterceptor implements Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint("---------Request------------");
    debugPrint("Method: ${options.method}");
    debugPrint("Uri: ${options.uri}");
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint("---------Response------------");
    debugPrint("StatusCode: ${response.statusCode}");
    debugPrint("Uri: ${response.realUri}");
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint("---------Error------------");
    debugPrint("Error: ${err.error}");
    debugPrint("Type: ${err.type}");
    debugPrint("Response: ${err.response}");
    debugPrint("Message: ${err.message}");
    handler.next(err);
  }
}
