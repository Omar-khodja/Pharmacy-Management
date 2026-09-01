import 'package:flutter/material.dart';
import 'package:pharmacy_management/core/storage/tokenstorage.dart';
import 'package:lottie/lottie.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    await Future.delayed(const Duration(seconds: 5));
    final token = await TokenStorage().getToken();
    if (!mounted) return;
    if (token != null) {
      Navigator.pushReplacementNamed(context, "/navigation");
    } else {
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/loading.json', width: 200, height: 200),
      ),
    );
  }
}
