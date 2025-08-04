import 'package:flutter/material.dart';
import 'login_form.dart';
import 'models/login_data.dart';

/// Main login widget that can be easily integrated into any Flutter app
class LoginWidget extends StatelessWidget {
  /// Callback function called when login is attempted
  final Function(LoginData) onLogin;
  
  /// Widget title
  final String? title;
  final TextStyle? titleStyle;
  
  /// Custom styling
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final BoxShadow? shadow;
  
  /// Form customization
  final InputDecoration? emailDecoration;
  final InputDecoration? passwordDecoration;
  final ButtonStyle? buttonStyle;
  final String? buttonText;
  
  /// Optional footer widget (e.g., "Don't have an account?" link)
  final Widget? footer;
  
  /// Form validation
  final String? Function(String?)? emailValidator;
  final String? Function(String?)? passwordValidator;
  
  /// Password visibility options
  final bool showPasswordToggle;
  final Widget? visibilityIcon;
  final Widget? visibilityOffIcon;

  const LoginWidget({
    Key? key,
    required this.onLogin,
    this.title,
    this.titleStyle,
    this.padding,
    this.backgroundColor,
    this.borderRadius,
    this.shadow,
    this.emailDecoration,
    this.passwordDecoration,
    this.buttonStyle,
    this.buttonText,
    this.footer,
    this.emailValidator,
    this.passwordValidator,
    this.showPasswordToggle = true,
    this.visibilityIcon,
    this.visibilityOffIcon,
  }) : super(key: key);  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: padding ?? const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.cardColor,
        borderRadius: borderRadius ?? BorderRadius.circular(12.0),
        boxShadow:
            shadow != null
                ? [shadow!]
                : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style:
                  titleStyle ??
                  theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
          ],
          LoginForm(
            onLogin: onLogin,
            emailDecoration: emailDecoration,
            passwordDecoration: passwordDecoration,
            buttonStyle: buttonStyle,
            buttonText: buttonText,
            emailValidator: emailValidator,
            passwordValidator: passwordValidator,
            showPasswordToggle: showPasswordToggle,
            visibilityIcon: visibilityIcon,
            visibilityOffIcon: visibilityOffIcon,
          ),
          if (footer != null) ...[const SizedBox(height: 16), footer!],
        ],
      ),
    );
  }
}
