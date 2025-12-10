import 'dart:async';
import 'package:flutter/material.dart';
import 'package:momentum/core/state/app_state.dart';
import 'package:momentum/features/auth/presentation/screens/welcome_screen.dart';
import 'package:momentum/features/home/presentation/screens/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 3));
    
    if (!mounted) return;
    
    final appState = AppStateProvider.of(context);
    
    // Navigate based on login status
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => appState.isLoggedIn 
            ? const DashboardScreen() 
            : const WelcomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF201A3F),
      body: Center(
        child: Image.asset('assets/images/logo.png', height: 150),
      ),
    );
  }
}
