import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  final SupabaseClient _client = Supabase.instance.client;

  SupabaseClient get client => _client;

  Future<void> initialize() async {
    await Supabase.initialize(
      url: 'https://alkwerscybtruiqkstus.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFsa3dlcnNjeWJ0cnVpcWtzdHVzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDE0NDM1NTksImV4cCI6MjA1NzAxOTU1OX0.754bIGxpqHI9k3QFWWSlXAIGLi9SVDcJePEqZT5Rnu8',
    );
  }

  Future<String> getRandomFunFact() async {
    final response =
        await _client
            .from('fun_facts') // Replace with your actual table name
            .select(
              'fact',
            ) // Assuming 'fact' is the column storing the fun fact
            .order('RANDOM()') // Get a random fun fact
            .limit(1)
            .single();

    return response['fact'] as String;
  }
}
