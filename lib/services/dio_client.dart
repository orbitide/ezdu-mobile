import 'package:dio/dio.dart';
import 'package:ezdu/core/constants/api_constants.dart';

class DioClient {
  late Dio _dio;
  String? _authToken;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectionTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        headers: {'Content-Type': 'application/json'},
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (_authToken != null && _authToken!.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $_authToken';
          }

          print('->>> ${options.method.toUpperCase()} ${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('-<<< ${response.statusCode}');
          return handler.next(response);
        },
        onError: (error, handler) {
          print('### ${error.message}');
          return handler.next(error);
        },
      ),
    );
    
    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: false,
      responseBody: true,
      responseHeader: false,
      error: true,
    ));
  }

  void setAuthToken(String token) {
    _authToken = token;
  }

  void clearAuthToken() {
    _authToken = null;
  }

  String _handleDioException(DioException e) {
    if (e.response != null) {
      final statusCode = e.response?.statusCode;
      final errorMessage = e.response?.data?['message'] ?? 'Server error';
      return '$errorMessage (Status: $statusCode)';
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. Check your internet.';
      case DioExceptionType.receiveTimeout:
        return 'Server took too long to respond.';
      case DioExceptionType.badResponse:
        return 'Bad response from server.';
      case DioExceptionType.cancel:
        return 'Request cancelled.';
      default:
        return 'Network error: ${e.message}';
    }
  }


  Future<T> get<T>(
      String endpoint, {
        Map<String, dynamic>? queryParameters,
        required T Function(Map<String, dynamic>) fromJson,
      }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        return fromJson(response.data as Map<String, dynamic>);
      }

      throw Exception('Request failed: ${response.statusCode}');
    } on DioException catch (e) {
      final message =
          e.response?.data?['message'] ?? 'Network error: ${e.message}';
      // throw Exception(message);
      throw Exception(_handleDioException(e));
    }
  }

  Future<T> post<T>(
      String endpoint, {
        required dynamic data,
        Map<String, dynamic>? queryParameters,
        required T Function(Map<String, dynamic>) fromJson,
      }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return fromJson(response.data as Map<String, dynamic>);
      }

      throw Exception('Request failed: ${response.statusCode}');
    } on DioException catch (e) {
      var message = 'Network error';
      final errorsData = e.response?.data?['errors'];

      if (errorsData != null && errorsData is List) {
        final errors = errorsData.map((e) => e.toString()).toList();
        if (errors.isNotEmpty) {
          message = errors[0];
        }
      } else if (e.response?.data?['message'] != null) {
        message = e.response?.data!['message'];
      }

      throw message;
    }
  }

  Future<T> put<T>(
      String endpoint, {
        required dynamic data,
        Map<String, dynamic>? queryParameters,
        required T Function(Map<String, dynamic>) fromJson,
      }) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: data,
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return fromJson(response.data as Map<String, dynamic>);
      }

      throw Exception('Request failed: ${response.statusCode}');
    } on DioException catch (e) {
      final message =
          e.response?.data?['message'] ?? 'Network error: ${e.message}';
      throw Exception(message);
    }
  }

  Future<T> patch<T>(
      String endpoint, {
        required dynamic data,
        Map<String, dynamic>? queryParameters,
        required T Function(Map<String, dynamic>) fromJson,
      }) async {
    try {
      final response = await _dio.patch(
        endpoint,
        data: data,
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return fromJson(response.data as Map<String, dynamic>);
      }

      throw Exception('Request failed: ${response.statusCode}');
    } on DioException catch (e) {
      final message =
          e.response?.data?['message'] ?? 'Network error: ${e.message}';
      throw Exception(message);
    }
  }

  Future<T> delete<T>(
      String endpoint, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        required T Function(Map<String, dynamic>) fromJson,
      }) async {
    try {
      final response = await _dio.delete(
        endpoint,
        data: data,
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        // Handle 204 No Content
        if (response.data == null) {
          return fromJson({} as Map<String, dynamic>);
        }
        return fromJson(response.data as Map<String, dynamic>);
      }

      throw Exception('Request failed: ${response.statusCode}');
    } on DioException catch (e) {
      final message =
          e.response?.data?['message'] ?? 'Network error: ${e.message}';
      throw Exception(message);
    }
  }




}
