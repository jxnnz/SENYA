import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import '../models/user_model.dart' as my_models;
import '../services/supabase_service.dart';

class AuthRepository {
  final SupabaseService _supabaseService = SupabaseService();

  Future<my_models.User?> signUp(
    String email,
    String password,
    String name,
  ) async {
    try {
      final response = await _supabaseService.client.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );

      final user = response.user;
      if (user == null) {
        throw Exception('User creation failed');
      }

      // Insert profile into 'profiles' table
      final profileInsertResponse =
          await _supabaseService.client.from('profiles').insert({
            'id': user.id,
            'email': email,
            'name': name,
            'streaks': 0, // Default streaks
            'hearts': 5, // Default hearts
            'rubies': 0, // Default rubies
            'avatar': null, // Default avatar
          }).select();

      if (profileInsertResponse.isEmpty) {
        throw Exception('Failed to insert profile into database');
      }

      return my_models.User.fromJson(profileInsertResponse.first);
    } catch (e) {
      throw Exception('Error during signup: $e');
    }
  }

  Future<my_models.User?> login(String email, String password) async {
    try {
      final response = await _supabaseService.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        return my_models.User.fromJson({
          'id': response.user!.id,
          'email': email,
        });
      }
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
    return null;
  }

  Future<void> logout() async {
    await _supabaseService.client.auth.signOut();
  }
}
