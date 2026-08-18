import 'package:flutter/material.dart';
import 'package:cook/features/onboarding/pages/onboarding_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _startLogoAnimation = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _startLogoAnimation = true;
      });
    });

    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const OnboardingPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: -20,
            left: -90,
            child: Image.asset(
              'assets/images/circle-grey.png',
              width: 200,
              fit: BoxFit.contain,
            ),
          ),

          Positioned(
            bottom: -10,
            right: -10,
            child: Image.asset(
              'assets/images/circle-orange.png',
              width: 180,
              fit: BoxFit.contain,
            ),
          ),

          Center(
            child: AnimatedOpacity(
              opacity: _startLogoAnimation ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeIn,
              child: Image.asset(
                'assets/images/logo.png',
                width: 150,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}