import 'package:dio/dio.dart';
import 'package:dio_logger/dio_logger.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.orianosy.com/',
        receiveDataWhenStatusError: true,
        connectTimeout:  10,
        receiveTimeout: 10,
        headers: {
          'secretKey': const String.fromEnvironment('SECRET_KEY'),
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.add(dioLoggerInterceptor);
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
  }) async {
    return await dio.post(
      url,
      data: data,
      queryParameters: query,
    );
  }

  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
  }) async {
    return await dio.put(
      url,
      data: data,
      queryParameters: query,
    );
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    return await dio.delete(
      url,
      queryParameters: query,
    );
  }
}