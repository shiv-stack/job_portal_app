import 'package:supabase_flutter/supabase_flutter.dart';
import '../constants/supabase_constants.dart';

class SupabaseService {
  static Future<void> initialize() async {
    if (SupabaseConstants.url.contains('YOUR_SUPABASE') || 
        SupabaseConstants.anonKey.contains('YOUR_SUPABASE')) {
      print('Supabase not initialized: Placeholder keys detected.');
      return;
    }
    
    await Supabase.initialize(
      url: SupabaseConstants.url,
      anonKey: SupabaseConstants.anonKey,
    );
  }

  // Handle nullable client access
  static SupabaseClient get client => Supabase.instance.client;
}
