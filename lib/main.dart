import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ia_art/Admin/admin_login.dart';
import 'package:ia_art/firebase_options.dart';
import 'package:ia_art/pages/home.dart';
import 'package:ia_art/pages/question.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
