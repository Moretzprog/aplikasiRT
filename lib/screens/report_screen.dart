import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key}); 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Panic Button',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
  
  }