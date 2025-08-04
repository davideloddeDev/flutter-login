import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  void _handleLogin(LoginData loginData) {
    // Handle login logic here
    print('Login attempt with email: ${loginData.email}');
    // You would typically call your authentication service here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Example'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: LoginWidget(
              title: 'Welcome Back',
              onLogin: _handleLogin,
              footer: TextButton(
                onPressed: () {
                  // Navigate to registration screen
                },
                child: const Text("Don't have an account? Sign up"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
