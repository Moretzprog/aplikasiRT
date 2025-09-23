import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Komplek'),
        backgroundColor: const Color(0xFFF5F3F3),
      ),
      body: const Center(child: Text('Halaman About Komplek')),
      backgroundColor: const Color(0xFFF5F3F3),
    );
  }
}
