import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_management/core/theme/apptheme.dart';
import 'package:pharmacy_management/feature/Authentication/domain/usecase/login_usecase.dart';
import 'package:pharmacy_management/feature/Authentication/presentaion/controlers/auth_cubit/auth_cubit.dart';
import 'package:pharmacy_management/feature/Authentication/presentaion/screen/login.dart';
import 'package:pharmacy_management/core/dependnce_injection/injection_container.dart'
    as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
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
      home: BlocProvider(
        create: (context) => AuthCubit(di.sl<LoginUsecase>()),
        child: const Login(),
      ),
    );
  }
}
