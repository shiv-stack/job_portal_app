import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<AuthResponse> signIn({required String email, required String password}) async {
    return await remoteDataSource.signIn(email: email, password: password);
  }

  @override
  Future<AuthResponse> signUp({required String email, required String password}) async {
    return await remoteDataSource.signUp(email: email, password: password);
  }

  @override
  Future<void> signOut() async {
    await remoteDataSource.signOut();
  }

  @override
  User? get currentUser => remoteDataSource.currentUser;

  @override
  Stream<AuthState> get authStateChanges => remoteDataSource.authStateChanges;
}
