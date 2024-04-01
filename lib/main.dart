import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ia_art/Admin/admin_login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
