import 'package:flutter/material.dart';
import 'screens/onboard_screen.dart';

void main() {
  runApp(const AplikasiKeamanan());
}

class AplikasiKeamanan extends StatelessWidget {
  const AplikasiKeamanan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Keamanan RT',
      theme: ThemeData(
        fontFamily: 'Inter',
        primarySwatch: Colors.blue,
      ),
      home: const OnboardingScreen(),
    );
  }
}