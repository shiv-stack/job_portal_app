import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/repositories/auth_repository.dart';

class MockAuthRepository implements AuthRepository {
  final _controller = StreamController<AuthState>.broadcast();

  // Mock user
  final _mockUser = const User(
    id: 'mock_user_123',
    appMetadata: {},
    userMetadata: {},
    aud: 'authenticated',
    createdAt: '',
  );

  @override
  Future<AuthResponse> signIn({required String email, required String password}) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate delay
    if (password == 'password') {
       _controller.add(AuthState(AuthChangeEvent.signedIn,Session(accessToken: 'mock_token', tokenType: 'bearer', user: _mockUser)));
      return AuthResponse(session: Session(accessToken: 'mock_token', tokenType: 'bearer', user: _mockUser), user: _mockUser);
    } else {
      throw const AuthException('Invalid login credentials');
    }
  }

  @override
  Future<AuthResponse> signUp({required String email, required String password}) async {
    await Future.delayed(const Duration(seconds: 1));
     _controller.add(AuthState(AuthChangeEvent.signedIn,Session(accessToken: 'mock_token', tokenType: 'bearer', user: _mockUser)));
     return AuthResponse(session: Session(accessToken: 'mock_token', tokenType: 'bearer', user: _mockUser), user: _mockUser);
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _controller.add(AuthState(AuthChangeEvent.signedOut, null));
  }

  @override
  User? get currentUser => _mockUser; // Always return user for now to bypass splash or handle in stream

  @override
  Stream<AuthState> get authStateChanges => _controller.stream;
}
