import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:security_app/core/netwoking/api_constants.dart';
import 'package:security_app/core/netwoking/auth_interceptor.dart';
import 'package:security_app/core/storage/app_prefs.dart';

class DioFactory {
  final AppPrefs _authLocalDataSource;
  DioFactory(this._authLocalDataSource);
   Dio createDio() {
    final BaseOptions options = BaseOptions(
      baseUrl: ApiConstants.baseApiUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      responseType: ResponseType.json,
    );

    final Dio dio = Dio(options);

    // Interceptors
    dio.interceptors.add(AuthInterceptor(_authLocalDataSource));

    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        compact: true,
      ),
    );

    return dio;
  }
}
