import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_login/flutter_login.dart';

void main() {
  group('LoginConfig Tests', () {
    setUp(() {
      // Reset configuration before each test
      LoginConfig.instance.reset();
    });

    test('should set and get base URL correctly', () {
      const testUrl = 'https://api.example.com';
      LoginConfig.instance.setBaseUrl(testUrl);
      
      expect(LoginConfig.instance.loginUrl, '$testUrl/auth/login');
    });

    test('should remove trailing slash from base URL', () {
      const testUrl = 'https://api.example.com/';
      LoginConfig.instance.setBaseUrl(testUrl);
      
      expect(LoginConfig.instance.loginUrl, 'https://api.example.com/auth/login');
    });

    test('should set custom login endpoint', () {
      const testUrl = 'https://api.example.com';
      const customEndpoint = '/custom/auth';
      
      LoginConfig.instance.setBaseUrl(testUrl);
      LoginConfig.instance.setLoginEndpoint(customEndpoint);
      
      expect(LoginConfig.instance.loginUrl, '$testUrl$customEndpoint');
    });

    test('should add leading slash to endpoint if missing', () {
      const testUrl = 'https://api.example.com';
      const customEndpoint = 'custom/auth';
      
      LoginConfig.instance.setBaseUrl(testUrl);
      LoginConfig.instance.setLoginEndpoint(customEndpoint);
      
      expect(LoginConfig.instance.loginUrl, '$testUrl/$customEndpoint');
    });

    test('should add custom headers', () {
      final customHeaders = {
        'Authorization': 'Bearer token123',
        'X-Custom-Header': 'custom-value',
      };
      
      LoginConfig.instance.addHeaders(customHeaders);
      final headers = LoginConfig.instance.headers;
      
      expect(headers['Authorization'], 'Bearer token123');
      expect(headers['X-Custom-Header'], 'custom-value');
      expect(headers['Content-Type'], 'application/json'); // Default header should still be there
    });

    test('should set timeout duration', () {
      const timeoutSeconds = 60;
      LoginConfig.instance.setTimeout(timeoutSeconds);
      
      expect(LoginConfig.instance.timeout, const Duration(seconds: timeoutSeconds));
    });

    test('should return null login URL when base URL is not set', () {
      expect(LoginConfig.instance.loginUrl, isNull);
    });

    test('should reset configuration to defaults', () {
      // Set some custom values
      LoginConfig.instance.setBaseUrl('https://test.com');
      LoginConfig.instance.setLoginEndpoint('/custom');
      LoginConfig.instance.addHeaders({'Custom': 'value'});
      LoginConfig.instance.setTimeout(60);
      
      // Reset
      LoginConfig.instance.reset();
      
      // Check defaults
      expect(LoginConfig.instance.loginUrl, isNull);
      expect(LoginConfig.instance.timeout, const Duration(seconds: 30));
      expect(LoginConfig.instance.headers['Content-Type'], 'application/json');
      expect(LoginConfig.instance.headers.containsKey('Custom'), false);
    });
  });

  group('LoginService Tests', () {
    test('should throw exception when base URL is not configured', () async {
      LoginConfig.instance.reset(); // Ensure no URL is set
      
      const loginData = LoginData(
        email: 'test@example.com',
        password: 'password123',
      );
      
      expect(
        () => LoginService.instance.login(loginData),
        throwsException,
      );
    });
  });
}
