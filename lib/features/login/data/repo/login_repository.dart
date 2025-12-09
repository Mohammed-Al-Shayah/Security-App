import 'package:security_app/core/netwoking/api_constants.dart';
import 'package:security_app/core/netwoking/api_service.dart';
import 'package:security_app/features/login/data/models/login_request.dart';
import 'package:security_app/features/login/data/models/login_response.dart';

class LoginRepository {
  final ApiService _apiService;

  LoginRepository(this._apiService);

  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    final request = LoginRequest(email: email, password: password);
    final dynamic data = await _apiService.post(
      ApiConstants.baseApiUrl + ApiConstants.authLogin,
      data: request.toJson(),
    );
    return LoginResponse.fromJson(data as Map<String, dynamic>);
  }
}
