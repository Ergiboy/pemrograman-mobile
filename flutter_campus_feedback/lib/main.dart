import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const CampusFeedbackApp());
}

class CampusFeedbackApp extends StatelessWidget {
  const CampusFeedbackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Feedback',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}