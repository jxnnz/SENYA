import 'package:flutter/material.dart';

class LoadingAnimationWidget extends StatefulWidget {
  final Future<String> Function() backgroundTask;
  final VoidCallback onComplete;

  const LoadingAnimationWidget({
    super.key,
    required this.backgroundTask,
    required this.onComplete,
  });

  @override
  _LoadingAnimationWidgetState createState() => _LoadingAnimationWidgetState();
}

class _LoadingAnimationWidgetState extends State<LoadingAnimationWidget> {
  String? funFact;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    funFact = await widget.backgroundTask();
    if (mounted) {
      setState(() {}); // Update UI
    }
    await Future.delayed(const Duration(seconds: 2)); // Simulate loading time
    widget.onComplete(); // Navigate after loading
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/loading.png', // Update this path as needed
              height: 100,
            ),
            const SizedBox(height: 16),
            const CircularProgressIndicator(color: Color(0xFFFF7F00)),
            const SizedBox(height: 16),
            const Text(
              'Fun Fact',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF7F00),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
                vertical: 8.0,
              ),
              child: Text(
                funFact ?? 'Loading...',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
