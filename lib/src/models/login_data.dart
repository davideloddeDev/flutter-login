/// Model class for login data
class LoginData {
  final String email;
  final String password;

  const LoginData({required this.email, required this.password});

  /// Creates a copy of this LoginData with the given fields replaced
  LoginData copyWith({String? email, String? password}) {
    return LoginData(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  String toString() {
    return 'LoginData(email: $email, password: [HIDDEN])';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LoginData &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
