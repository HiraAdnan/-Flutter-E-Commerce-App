import 'package:flutter_test/flutter_test.dart';
import 'package:shopease/features/auth/data/services/mock_auth_service.dart';

void main() {
  late MockAuthService service;

  setUp(() {
    service = MockAuthService();
  });

  group('MockAuthService', () {
    group('login', () {
      test('returns user with matching email', () async {
        final user = await service.login('demo@shopease.com', 'password');
        expect(user.email, 'demo@shopease.com');
        expect(user.id, 'user_1');
      });

      test('sets currentUser after login', () async {
        expect(service.currentUser, isNull);
        await service.login('demo@shopease.com', 'password');
        expect(service.currentUser, isNotNull);
        expect(service.currentUser!.email, 'demo@shopease.com');
      });

      test('derives name from email', () async {
        final user = await service.login('john.doe@test.com', 'pass');
        expect(user.name, 'John Doe');
      });

      test('throws on empty email', () async {
        expect(
          () => service.login('', 'password'),
          throwsException,
        );
      });

      test('throws on empty password', () async {
        expect(
          () => service.login('email@test.com', ''),
          throwsException,
        );
      });
    });

    group('register', () {
      test('returns user with provided name and email', () async {
        final user = await service.register('Jane Doe', 'jane@test.com', 'password123');
        expect(user.name, 'Jane Doe');
        expect(user.email, 'jane@test.com');
      });

      test('sets currentUser after registration', () async {
        await service.register('Jane', 'jane@test.com', 'password123');
        expect(service.currentUser, isNotNull);
      });

      test('throws on empty name', () async {
        expect(
          () => service.register('', 'jane@test.com', 'password123'),
          throwsException,
        );
      });

      test('throws on short password', () async {
        expect(
          () => service.register('Jane', 'jane@test.com', '12345'),
          throwsException,
        );
      });
    });

    group('forgotPassword', () {
      test('succeeds with valid email', () async {
        await expectLater(
          service.forgotPassword('test@test.com'),
          completes,
        );
      });

      test('throws on empty email', () async {
        expect(
          () => service.forgotPassword(''),
          throwsException,
        );
      });
    });

    group('logout', () {
      test('clears currentUser', () async {
        await service.login('test@test.com', 'password');
        expect(service.currentUser, isNotNull);
        await service.logout();
        expect(service.currentUser, isNull);
      });
    });
  });
}
