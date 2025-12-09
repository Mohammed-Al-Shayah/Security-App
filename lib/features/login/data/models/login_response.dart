import 'package:security_app/features/login/data/models/user.dart';

class LoginResponse {
  final bool success;
  final String message;
  final String token;
  final User? user;

  LoginResponse({
    required this.success,
    required this.message,
    required this.token,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    final dataMap = data is Map<String, dynamic> ? data : <String, dynamic>{};
    final userJson = dataMap['user'];
    return LoginResponse(
      success: json['success'] == true,
      message: json['message']?.toString() ?? '',
      token: dataMap['token']?.toString() ?? '',
      user: userJson is Map<String, dynamic> ? User.fromJson(userJson) : null,
    );
  }
}
