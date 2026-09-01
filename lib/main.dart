import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_management/core/theme/apptheme.dart';
import 'package:pharmacy_management/core/usecase/longout_usecase.dart';
import 'package:pharmacy_management/feature/Authentication/domain/usecase/login_usecase.dart';
import 'package:pharmacy_management/core/controler/auth_cubit/auth_cubit.dart';
import 'package:pharmacy_management/feature/Authentication/presentaion/screen/login.dart';
import 'package:pharmacy_management/core/dependnce_injection/injection_container.dart'
    as di;
import 'package:pharmacy_management/feature/dashboard/presentaion/screen/dashboard.dart';
import 'package:pharmacy_management/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Apptheme.lightTheme,
      routes: {
        "/splash": (context) => const Splashscreen(),
        "/login": (context) => BlocProvider(
          create: (context) => AuthCubit(
            loginUsecase: di.sl<LoginUsecase>(),
            longOutUsecase: di.sl<LongOutUsecase>(),
          ),
          child: const Login(),
        ),
        "/home": (context) => BlocProvider(
          create: (context) => AuthCubit(
            loginUsecase: di.sl<LoginUsecase>(),
            longOutUsecase: di.sl<LongOutUsecase>(),
          ),
          child: const Dashboard(),
        ),
      },
      initialRoute: "/splash",
    );
  }
}
