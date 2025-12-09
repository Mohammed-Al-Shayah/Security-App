// import 'package:dio/dio.dart';
// import 'package:security_app/core/netwoking/api_constants.dart';
// import 'package:security_app/features/incidents/data/models/incident_request_model.dart';
// import 'package:security_app/features/incidents/data/models/incident_response_model.dart';
// import 'package:security_app/features/login/data/models/login_request.dart';
// import 'package:security_app/features/login/data/models/login_response.dart';
// import 'package:security_app/features/patrols/data/model/patrol_request.dart';

// class ApiService {
//   final Dio _dio;
//   ApiService(this._dio);

//   Future<LoginResponse> login(LoginRequest request) async {
//     try {
//       final response = await _dio.post(
//         ApiConstants.baseApiUrl + ApiConstants.authLogin,
//         data: request.toJson(),
//       );

//       return LoginResponse.fromJson(response.data);
//     } on DioException catch (e) {
//       throw Exception(_handleDioError(e));
//     }
//   }

//   String _handleDioError(DioException e) {
//     if (e.response != null) {
//       final data = e.response!.data;
//       if (data is Map && data['message'] != null) {
//         return data['message'].toString();
//       }
//       return 'Request failed with status code: ${e.response!.statusCode}';
//     } else {
//       return 'Connection error, please check your internet.';
//     }
//   }

//   Future<List<IncidentResponseModel>> fetchIncidents(String token) async {
//     try {
//       final response = await _dio.get(
//         ApiConstants.baseApiUrl + ApiConstants.guardIncidents,
//         options: Options(headers: ApiConstants.authHeaders(token)),
//       );
//       final data = response.data;
//       if (data is Map<String, dynamic> && data['data'] is List) {
//         final incidentsList = data['data'] as List;
//         return incidentsList
//             .whereType<Map<String, dynamic>>()
//             .map(IncidentResponseModel.fromJson)
//             .toList();
//       }
//       return [];
//     } on DioException catch (e) {
//       throw Exception(_handleDioError(e));
//     }
//   }

//   Future<IncidentResponseModel> createIncidents(
//     String token,
//     IncidentRequestModel request,
//   ) async {
//     try {
//       final response = await _dio.post(
//         ApiConstants.baseApiUrl + ApiConstants.guardIncidents,
//         data: request.toJson(),
//         options: Options(headers: ApiConstants.authHeaders(token)),
//       );

//       final data = response.data;
//       if (data is Map<String, dynamic>) {
//         final incidentJson = data['data'] is Map<String, dynamic>
//             ? data['data']
//             : data;
//         if (incidentJson is Map<String, dynamic>) {
//           return IncidentResponseModel.fromJson(incidentJson);
//         }
//       }
//       throw Exception('Unexpected response from server');
//     } on DioException catch (e) {
//       throw Exception(_handleDioError(e));
//     }
//   }

//   Future<List<dynamic>> getPatrols() async {
//     final Response response = await _dio.get(
//       ApiConstants.baseApiUrl + ApiConstants.guardPatrols,
//     );

//     // التحقق من أن الـ response يحتوي key اسمه data
//     if (response.data is Map<String, dynamic>) {
//       final map = response.data as Map<String, dynamic>;
//       if (map.containsKey("data")) {
//         return map["data"] as List<dynamic>;
//       }
//     }

//     throw Exception("Invalid patrols response format");
//   }

//   Future<Map<String, dynamic>> createPatrol(PatrolRequest request) async {
//     final Response response = await _dio.post(
//       ApiConstants.baseApiUrl + ApiConstants.guardPatrols,
//       data: request.toJson(),
//     );

//     if (response.data is Map<String, dynamic>) {
//       return response.data as Map<String, dynamic>;
//     }

//     throw Exception('Invalid createPatrol response format');
//   }
// }

import 'package:dio/dio.dart';

/// نوع فانكشن تجيب لك الـ Token من أي مكان (SharedPreferences مثلاً)
typedef TokenProvider = Future<String?> Function();

/// كلاس استثناء مخصص للـ API
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  ApiException(this.message, {this.statusCode, this.data});

  @override
  String toString() =>
      'ApiException(statusCode: $statusCode, message: $message, data: $data)';
}

class ApiService {
  final Dio _dio;
  final TokenProvider? _tokenProvider;

  ApiService({
    required String baseUrl,
    TokenProvider? tokenProvider,
    Dio? dio,
  })  : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: baseUrl,
                connectTimeout: const Duration(seconds: 20),
                receiveTimeout: const Duration(seconds: 20),
                headers: <String, dynamic>{
                  'Accept': 'application/json',
                  'Content-Type': 'application/json',
                },
              ),
            ),
        _tokenProvider = tokenProvider {
    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          // لو عندنا provider للتوكن، نجيبه ونضيفه على الهيدر
          if (_tokenProvider != null) {
            final String? token = await _tokenProvider();
            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          }

          // تقدر تطبع الديبغ لو حابب
          print('--> ${options.method} ${options.uri}');
          print('Headers: ${options.headers}');
          print('Data: ${options.data}');

          handler.next(options);
        },
        onResponse:
            (Response<dynamic> response, ResponseInterceptorHandler handler) {
          // print('<-- ${response.statusCode} ${response.requestOptions.uri}');
          handler.next(response);
        },
        onError: (DioException e, ErrorInterceptorHandler handler) {
          // هنا نقدر نطبع أو نعالج الأخطاء
          print('ERROR[${e.response?.statusCode}] => ${e.message}');
          handler.next(e);
        },
      ),
    );
  }

  /// دالة عامة للـ GET
  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response<dynamic> response = await _dio.get<dynamic>(
        endpoint,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// دالة عامة للـ POST
  Future<dynamic> post(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response<dynamic> response = await _dio.post<dynamic>(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// دالة عامة للـ PUT
  Future<dynamic> put(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response<dynamic> response = await _dio.put<dynamic>(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// دالة عامة للـ DELETE
  Future<dynamic> delete(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response<dynamic> response = await _dio.delete<dynamic>(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// هنا نعمل ماب للأخطاء من Dio لــ ApiException برسالة أوضح
  ApiException _handleDioError(DioException e) {
    final Response<dynamic>? res = e.response;

    // حالات Timeout
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return ApiException(
        'انتهت مهلة الاتصال بالسيرفر، حاول مرة أخرى.',
      );
    }

    // لو في Response من السيرفر
    if (res != null) {
      final int? statusCode = res.statusCode;
      final dynamic data = res.data;

      String message = 'حدث خطأ غير متوقع';

      if (statusCode != null) {
        if (statusCode >= 400 && statusCode < 500) {
          message = 'خطأ في البيانات المرسلة أو صلاحيات الوصول.';
        } else if (statusCode >= 500) {
          message = 'مشكلة في السيرفر، حاول لاحقاً.';
        }
      }

      // لو السيرفر رجع message واضحة
      if (data is Map<String, dynamic>) {
        if (data['message'] is String) {
          message = data['message'] as String;
        } else if (data['error'] is String) {
          message = data['error'] as String;
        }
      }

      return ApiException(
        message,
        statusCode: statusCode,
        data: data,
      );
    }

    // لو ما في response أصلاً (نت مقطوع، DNS، الخ)
    return ApiException(
      'تعذر الاتصال بالسيرفر، تأكد من اتصال الإنترنت.',
    );
  }
}
