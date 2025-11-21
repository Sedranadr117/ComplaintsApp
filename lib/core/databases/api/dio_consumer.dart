import 'package:complaint_app/core/databases/api/api_consumer.dart';
import 'package:complaint_app/core/databases/api/end_points.dart';
import 'package:complaint_app/core/databases/cache/cache_helper.dart';
import 'package:complaint_app/core/errors/exceptions.dart';
import 'package:dio/dio.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;
  final SecureStorageHelper _secureStorageHelper = SecureStorageHelper.instance;
  final String _tokenKey = 'auth_token';

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = EndPoints.baserUrl;
  }

  Future<Map<String, dynamic>> _getAuthorizationHeader() async {
    // final token = await _secureStorageHelper.getString(_tokenKey);
    // if (token != null && token.isNotEmpty) {
    //   return {'Authorization': 'Bearer $token'};
    // }
    // return {};
    const fixedToken =
        'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJzaGF6YXRhaGFuQGdtYWlsLmNvbSIsImlhdCI6MTc2MzU2MDgyMCwiZXhwIjoxNzYzNjQ3MjIwfQ.obyfTBx4RzYzDo6CI62x-aiBGMRuAzh40GXPyU7x2-U';
    return {'Authorization': 'Bearer $fixedToken'};
  }

  //!POST
  @override
  @override
  Future post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final authHeader = await _getAuthorizationHeader();

      var res = await dio.post(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
        options: Options(headers: authHeader),
      );

      return res.data; // << هاد لازم ترجعيه
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  //!GET
  @override
  Future get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final authHeader = await _getAuthorizationHeader();

      var res = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: authHeader),
      );
      return res.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  //!DELETE
  @override
  Future delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final authHeader = await _getAuthorizationHeader();

      var res = await dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: authHeader),
      );
      return res.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  @override
  Future put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final authHeader = await _getAuthorizationHeader();

      var res = await dio.patch(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
        options: Options(headers: authHeader),
      );
      return res.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }
}
