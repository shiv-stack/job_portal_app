import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSource({required this.supabaseClient});

  Future<AuthResponse> signIn({required String email, required String password}) async {
    return await supabaseClient.auth.signInWithPassword(email: email, password: password);
  }

  Future<AuthResponse> signUp({required String email, required String password}) async {
    return await supabaseClient.auth.signUp(email: email, password: password);
  }

  Future<void> signOut() async {
    await supabaseClient.auth.signOut();
  }

  User? get currentUser => supabaseClient.auth.currentUser;

  Stream<AuthState> get authStateChanges => supabaseClient.auth.onAuthStateChange;
}
