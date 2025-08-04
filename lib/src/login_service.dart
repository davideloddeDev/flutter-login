import 'dart:convert';
import 'package:http/http.dart' as http;
import 'login_config.dart';
import 'models/login_data.dart';

/// Response from login attempt
class LoginResponse {
  final bool success;
  final String? token;
  final String? message;
  final Map<String, dynamic>? userData;
  final int statusCode;

  const LoginResponse({
    required this.success,
    this.token,
    this.message,
    this.userData,
    required this.statusCode,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json, int statusCode) {
    return LoginResponse(
      success: statusCode >= 200 && statusCode < 300,
      token: json['token'] as String?,
      message: json['message'] as String?,
      userData: json['user'] as Map<String, dynamic>?,
      statusCode: statusCode,
    );
  }
}

/// Service for handling authentication HTTP requests
class LoginService {
  static LoginService? _instance;

  /// Singleton instance
  static LoginService get instance {
    _instance ??= LoginService._internal();
    return _instance!;
  }

  LoginService._internal();

  /// Perform login with the provided credentials
  Future<LoginResponse> login(LoginData loginData) async {
    final config = LoginConfig.instance;
    final url = config.loginUrl;

    if (url == null) {
      throw Exception(
          'Base URL not configured. Call LoginConfig.instance.setBaseUrl() first.');
    }

    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: config.headers,
            body: jsonEncode({
              'email': loginData.email,
              'password': loginData.password,
            }),
          )
          .timeout(config.timeout);

      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      return LoginResponse.fromJson(responseData, response.statusCode);
    } catch (e) {
      return LoginResponse(
        success: false,
        message: 'Network error: ${e.toString()}',
        statusCode: -1,
      );
    }
  }

  /// Perform custom login with custom URL and headers
  Future<LoginResponse> customLogin(
    LoginData loginData, {
    required String url,
    Map<String, String>? headers,
    Duration? timeout,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: headers ?? {'Content-Type': 'application/json'},
            body: jsonEncode({
              'email': loginData.email,
              'password': loginData.password,
            }),
          )
          .timeout(timeout ?? const Duration(seconds: 30));

      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      return LoginResponse.fromJson(responseData, response.statusCode);
    } catch (e) {
      return LoginResponse(
        success: false,
        message: 'Network error: ${e.toString()}',
        statusCode: -1,
      );
    }
  }
}
