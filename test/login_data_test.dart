import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_login/flutter_login.dart';

void main() {
  group('LoginData', () {
    test('should create LoginData with email and password', () {
      const loginData = LoginData(
        email: 'test@example.com',
        password: 'password123',
      );

      expect(loginData.email, 'test@example.com');
      expect(loginData.password, 'password123');
    });

    test('should create copy with updated values', () {
      const originalData = LoginData(
        email: 'test@example.com',
        password: 'password123',
      );

      final updatedData = originalData.copyWith(
        email: 'new@example.com',
      );

      expect(updatedData.email, 'new@example.com');
      expect(updatedData.password, 'password123');
    });

    test('should have correct toString representation', () {
      const loginData = LoginData(
        email: 'test@example.com',
        password: 'password123',
      );

      expect(
        loginData.toString(),
        'LoginData(email: test@example.com, password: [HIDDEN])',
      );
    });

    test('should have correct equality comparison', () {
      const loginData1 = LoginData(
        email: 'test@example.com',
        password: 'password123',
      );

      const loginData2 = LoginData(
        email: 'test@example.com',
        password: 'password123',
      );

      const loginData3 = LoginData(
        email: 'different@example.com',
        password: 'password123',
      );

      expect(loginData1, equals(loginData2));
      expect(loginData1, isNot(equals(loginData3)));
    });
  });
}
