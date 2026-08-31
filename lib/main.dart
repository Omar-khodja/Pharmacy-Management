import 'package:flutter/material.dart';
import 'package:pharmacy_management/core/theme/apptheme.dart';
import 'package:pharmacy_management/feature/Authentication/presentaion/screen/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Apptheme.lightTheme,
      home: const Login(),
    );
  }
}
