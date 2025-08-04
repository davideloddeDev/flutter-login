/// Global configuration for the flutter_login package
class LoginConfig {
  static LoginConfig? _instance;
  
  /// Singleton instance
  static LoginConfig get instance {
    _instance ??= LoginConfig._internal();
    return _instance!;
  }
  
  LoginConfig._internal();
  
  /// Base URL for authentication endpoints
  String? _baseUrl;
  
  /// Login endpoint path (will be appended to baseUrl)
  String _loginEndpoint = '/auth/login';
  
  /// Custom headers to be sent with requests
  Map<String, String> _headers = {
    'Content-Type': 'application/json',
  };
  
  /// Timeout for HTTP requests in seconds
  int _timeoutSeconds = 30;
  
  /// Configure the base URL for authentication
  void setBaseUrl(String url) {
    _baseUrl = url.endsWith('/') ? url.substring(0, url.length - 1) : url;
  }
  
  /// Configure the login endpoint path
  void setLoginEndpoint(String endpoint) {
    _loginEndpoint = endpoint.startsWith('/') ? endpoint : '/$endpoint';
  }
  
  /// Add custom headers for requests
  void addHeaders(Map<String, String> headers) {
    _headers.addAll(headers);
  }
  
  /// Set request timeout
  void setTimeout(int seconds) {
    _timeoutSeconds = seconds;
  }
  
  /// Get the complete login URL
  String? get loginUrl {
    if (_baseUrl == null) return null;
    return '$_baseUrl$_loginEndpoint';
  }
  
  /// Get configured headers
  Map<String, String> get headers => Map.from(_headers);
  
  /// Get timeout duration
  Duration get timeout => Duration(seconds: _timeoutSeconds);
  
  /// Reset configuration to defaults
  void reset() {
    _baseUrl = null;
    _loginEndpoint = '/auth/login';
    _headers = {
      'Content-Type': 'application/json',
    };
    _timeoutSeconds = 30;
  }
}
