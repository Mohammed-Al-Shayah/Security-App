class ApiConstants {
  ApiConstants._();

  // Base configuration
  static const String apibaseUrl = 'https://security-api-laravel.onrender.com';
  static const String apiPrefix = '/api';
  // static const String apiVersion = 'v1';

  // Computed base API URL
  static String get baseApiUrl => '$apibaseUrl$apiPrefix';

  // Timeouts
  static const Duration requestTimeout = Duration(seconds: 30);

  // Default headers
  static const Map<String, String> defaultHeaders = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  // Helper to create auth headers
  static Map<String, String> authHeaders(String token) {
    return {'Authorization': 'Bearer $token', ...defaultHeaders};
  }

  // Common content types
  static const String contentTypeJson = 'application/json';
  static const String contentTypeForm = 'application/x-www-form-urlencoded';
  static const String contentTypeMultipart = 'multipart/form-data';

  // HTTP status codes (commonly used)
  static const int success = 200;
  static const int created = 201;
  static const int noContent = 204;
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int conflict = 409;
  static const int serverError = 500;

  // Endpoint paths
  static const String authLogin = '/auth/login';
  static const String guardIncidents = '/guard/incidents';
  static const String users = 'users';
  static const String posts = 'posts';
  static const String items = 'items';
  static const String guardPatrols = '/guard/patrols';

  // Helpers to build full endpoint URLs
  static String endpoint(String path) => '$baseApiUrl/$path';
  static String resource(String resourceName, [String? id]) =>
      id == null ? endpoint(resourceName) : endpoint('$resourceName/$id');

  // Examples:
  // ApiConstants.endpoint(ApiConstants.authLogin)
  // ApiConstants.resource(ApiConstants.users, '123')
}
