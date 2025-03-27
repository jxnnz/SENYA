import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'services/supabase_service.dart';
import 'screens/splash_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/login_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/new_password_screen.dart';
import 'screens/successpw_screen.dart';
//import 'screens/funfact_loading_screen.dart';
import 'screens/loading_screen.dart';
import 'screens/home_screen.dart';

final SupabaseService supabaseService = SupabaseService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://alkwerscybtruiqkstus.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFsa3dlcnNjeWJ0cnVpcWtzdHVzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDE0NDM1NTksImV4cCI6MjA1NzAxOTU1OX0.754bIGxpqHI9k3QFWWSlXAIGLi9SVDcJePEqZT5Rnu8',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SENYA - Learn FSL',
      theme: ThemeData(
        primaryColor: const Color(0xFFFF7F00),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF7F00),
          primary: const Color(0xFFFF7F00),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF7F00),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/signup': (context) => const SignupScreen(),
        '/login': (context) => const LoginScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/new-password': (context) => const NewPasswordScreen(),
        '/success':
            (context) => SuccessPasswordScreen(
              message: 'Password Changed Successfully',
              buttonText: 'Back to Log In',
              onButtonPressed:
                  () => Navigator.pushReplacementNamed(context, '/login'),
            ),
        '/loading':
            (context) => LoadingAnimationWidget(
              onComplete: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              backgroundTask: () async {
                return await supabaseService.getRandomFunFact();
              },
            ),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
