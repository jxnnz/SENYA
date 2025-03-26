// lib/screens/loading_screen.dart
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToWelcome();
  }

  _navigateToWelcome() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/welcome');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Color(0xFFF7B733), // Bright Yellow (#fdc830)
              Color(0xFFFF7904), // Warm Orange (#f37335)
            ],
            center: Alignment.center, // Centered gradient
            radius: 0.8, // Adjust for how far the colors spread
            focal: Alignment.center, // Focus in the middle
            focalRadius: 0.2, // Controls color concentration at the center
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: Image.asset(
                  'assets/images/LOGO.png', // Path to your logo image
                  fit: BoxFit.cover, // Adjust the image fit type
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
