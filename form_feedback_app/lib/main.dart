import 'package:flutter/material.dart';
import 'pages/feedback_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Feedback',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const FeedbackFormPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
