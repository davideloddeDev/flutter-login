import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_login/flutter_login.dart';

void main() {
  group('LoginWidget Tests', () {
    testWidgets('should render login form with email and password fields',
        (WidgetTester tester) async {
      bool loginCalled = false;
      LoginData? receivedData;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoginWidget(
              title: 'Test Login',
              onLogin: (data) {
                loginCalled = true;
                receivedData = data;
              },
            ),
          ),
        ),
      );

      // Verify that the title is displayed
      expect(find.text('Test Login'), findsOneWidget);

      // Verify that email and password fields are present
      expect(find.byType(TextFormField), findsNWidgets(2));

      // Verify that the login button is present
      expect(find.text('Login'), findsOneWidget);
    });

    testWidgets('should validate email field when empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoginWidget(
              onLogin: (data) {},
            ),
          ),
        ),
      );

      // Tap the login button without entering any data
      await tester.tap(find.text('Login'));
      await tester.pump();

      // Expect validation error for email
      expect(find.text('Please enter your email'), findsOneWidget);
    });

    testWidgets('should validate password field when empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoginWidget(
              onLogin: (data) {},
            ),
          ),
        ),
      );

      // Enter valid email but leave password empty
      await tester.enterText(
          find.byType(TextFormField).first, 'test@example.com');

      // Tap the login button
      await tester.tap(find.text('Login'));
      await tester.pump();

      // Expect validation error for password
      expect(find.text('Please enter your password'), findsOneWidget);
    });

    testWidgets('should call onLogin when form is valid',
        (WidgetTester tester) async {
      bool loginCalled = false;
      LoginData? receivedData;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoginWidget(
              onLogin: (data) {
                loginCalled = true;
                receivedData = data;
              },
            ),
          ),
        ),
      );

      // Enter valid email and password
      final emailField = find.byType(TextFormField).first;
      final passwordField = find.byType(TextFormField).last;

      await tester.enterText(emailField, 'test@example.com');
      await tester.enterText(passwordField, 'password123');

      // Tap the login button
      await tester.tap(find.text('Login'));
      await tester.pump();

      // Verify that the login callback was called with correct data
      expect(loginCalled, true);
      expect(receivedData?.email, 'test@example.com');
      expect(receivedData?.password, 'password123');
    });

    testWidgets('should toggle password visibility icon',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoginWidget(
              onLogin: (data) {},
            ),
          ),
        ),
      );

      // Find and tap the visibility toggle button
      final visibilityButton = find.byIcon(Icons.visibility);
      expect(visibilityButton, findsOneWidget);

      await tester.tap(visibilityButton);
      await tester.pump();

      // Icon should change to visibility_off
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    });
  });
}
