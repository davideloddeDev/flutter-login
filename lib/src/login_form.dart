import 'package:flutter/material.dart';
import 'models/login_data.dart';

/// A customizable login form widget
class LoginForm extends StatefulWidget {
  /// Callback function called when login is attempted
  final Function(LoginData) onLogin;
  
  /// Custom styling for the form
  final InputDecoration? emailDecoration;
  final InputDecoration? passwordDecoration;
  
  /// Button styling
  final ButtonStyle? buttonStyle;
  final String? buttonText;
  
  /// Form validation
  final String? Function(String?)? emailValidator;
  final String? Function(String?)? passwordValidator;

  const LoginForm({
    Key? key,
    required this.onLogin,
    this.emailDecoration,
    this.passwordDecoration,
    this.buttonStyle,
    this.buttonText,
    this.emailValidator,
    this.passwordValidator,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _defaultEmailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _defaultPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      final loginData = LoginData(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      widget.onLogin(loginData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: widget.emailDecoration ??
                const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  prefixIcon: Icon(Icons.email),
                ),
            validator: widget.emailValidator ?? _defaultEmailValidator,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: widget.passwordDecoration ??
                InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
            validator: widget.passwordValidator ?? _defaultPasswordValidator,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _handleLogin,
            style: widget.buttonStyle,
            child: Text(widget.buttonText ?? 'Login'),
          ),
        ],
      ),
    );
  }
}
