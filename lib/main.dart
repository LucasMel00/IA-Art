import 'package:flutter/material.dart';
import 'package:ia_art/Admin/admin_login.dart';
import 'package:ia_art/pages/home.dart';
import 'package:ia_art/pages/question.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AdminLogin(),
      debugShowCheckedModeBanner: false,
    );
  }
}
