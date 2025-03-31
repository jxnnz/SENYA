import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'services/supabase_service.dart';
import 'package:app_links/app_links.dart';
import 'dart:async';
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
import 'screens/flashcard_screen.dart';

final SupabaseService supabaseService = SupabaseService();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://alkwerscybtruiqkstus.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFsa3dlcnNjeWJ0cnVpcWtzdHVzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDE0NDM1NTksImV4cCI6MjA1NzAxOTU1OX0.754bIGxpqHI9k3QFWWSlXAIGLi9SVDcJePEqZT5Rnu8',
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppLinks _appLinks;
  StreamSubscription<Uri>? _sub;

  @override
  void initState() {
    super.initState();
    _appLinks = AppLinks();
    _handleIncomingLinks();
  }

  void _handleIncomingLinks() async {
    final Uri? initialUri = await _appLinks.getInitialLink();
    if (initialUri != null) {
      _processDeepLink(initialUri);
    }

    _sub = _appLinks.uriLinkStream.listen(
      (Uri uri) {
        _processDeepLink(uri);
      },
      onError: (err) {
        debugPrint('Error handling deep link: $err');
      },
    );
  }

  void _processDeepLink(Uri uri) {
    debugPrint('Received deep link: $uri');

    if (uri.host == 'new-password') {
      navigatorKey.currentState?.pushNamed('/new-password');
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
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
            foregroundColor: Colors.black,
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
        '/flashcard': (context) => const FlashcardScreen(),
      },
    );
  }
}
