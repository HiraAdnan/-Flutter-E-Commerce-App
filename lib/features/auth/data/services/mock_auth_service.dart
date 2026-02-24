import '../models/user_model.dart';
import '../../../../core/constants/app_constants.dart';

class MockAuthService {
  AppUser? _currentUser;

  AppUser? get currentUser => _currentUser;

  Future<AppUser> login(String email, String password) async {
    await Future.delayed(AppConstants.mockNetworkDelay);

    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email and password are required');
    }

    // Accept any email/password for demo
    _currentUser = AppUser(
      id: 'user_1',
      name: _nameFromEmail(email),
      email: email,
      avatarUrl: 'https://picsum.photos/seed/avatar/200/200',
    );
    return _currentUser!;
  }

  Future<AppUser> register(String name, String email, String password) async {
    await Future.delayed(AppConstants.mockNetworkDelay);

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      throw Exception('All fields are required');
    }
    if (password.length < 6) {
      throw Exception('Password must be at least 6 characters');
    }

    _currentUser = AppUser(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      email: email,
      avatarUrl: 'https://picsum.photos/seed/avatar/200/200',
    );
    return _currentUser!;
  }

  Future<void> forgotPassword(String email) async {
    await Future.delayed(AppConstants.mockNetworkDelay);
    if (email.isEmpty) {
      throw Exception('Email is required');
    }
    // Mock: always succeeds
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _currentUser = null;
  }

  String _nameFromEmail(String email) {
    final local = email.split('@').first;
    return local
        .replaceAll(RegExp(r'[._-]'), ' ')
        .split(' ')
        .map((w) => w.isNotEmpty ? '${w[0].toUpperCase()}${w.substring(1)}' : '')
        .join(' ');
  }
}
