import 'package:dio/dio.dart';
import 'package:security_app/core/storage/app_prefs.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._authLocalDataSource);

  final AppPrefs _authLocalDataSource;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    // U,O"U, U.O USOúU,O1 OU,OñUSUŸU^O3O¦
    final String? token = _authLocalDataSource.getToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // UØU+O U,OO-U,U<O U.U.UŸU+ O¦O¦OæOñU? U,U^ OU,U? statusCode = 401 U.O®U,OU<
    // U^O¦O1U.U, logout OœU^ refresh token
    return handler.next(err);
  }
}
