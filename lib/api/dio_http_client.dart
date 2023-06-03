
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:wingman/api/api_end_points.dart';
import 'package:wingman/api/api_key_strings.dart';
import 'package:wingman/utils/shared_preference.dart';

class DioHttpClient{
  late Dio _dio;

  DioHttpClient(bool isLocalHost){
    _dio = Dio(getBaseOptions(isLocalHost));
    _dio.interceptors.add(getInterceptor());
  }

  Future<Response> postRequest(String endPoint, Map<String, String> body, [Map<String, dynamic>? queryParams]) async {
    Response response;
    try {
      response = await _dio.post(endPoint,
          data: jsonEncode(body),
          options: getOptions(),
          queryParameters: queryParams);
    } on DioError catch (e) {
      if (kDebugMode) {
        print("DioError: ${e.message}, ${e.response}");
      }
      rethrow;
    }
    return response;
  }


  BaseOptions getBaseOptions(bool isLocalHost){
    return BaseOptions(
      baseUrl: isLocalHost?"":ApiEndPoints.baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    );
  }

  InterceptorsWrapper getInterceptor(){
    return InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        if (kDebugMode) {
          print("Request : Method ${options.method}, ${options.uri},  ${options.headers},  ${options.data}");
          print("Request completed : ${handler.isCompleted}");
        }
        return handler.next(options);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        if (kDebugMode) {
          print("Response: ${response.data}");
          print("JsonResponse: ${jsonEncode(response.data)}");
        }
        return handler.next(response);
      },
      onError: (DioError e, ErrorInterceptorHandler handler) {
        if (kDebugMode) {
          print("Error ${e.message}");
        }
        return handler.next(e);
      },
    );
  }
  Options getOptions() {
    Map<String, dynamic> header = {};
    if (sharedPrefs.token != null) {
      header.putIfAbsent(ApiKeyStrings.token, () => sharedPrefs.token);
    }
    return Options(headers: header );
  }
}