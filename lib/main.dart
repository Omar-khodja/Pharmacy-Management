import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_management/core/controler/medicien_mangment_bloc/medicien_mangment_bloc.dart';
import 'package:pharmacy_management/core/theme/apptheme.dart';

import 'package:pharmacy_management/core/controler/auth_cubit/auth_cubit.dart';
import 'package:pharmacy_management/feature/Authentication/presentaion/screen/login.dart';
import 'package:pharmacy_management/core/dependnce_injection/injection_container.dart'
    as di;
import 'package:pharmacy_management/feature/Inventory/presentaion/controlers/inventory_cubit/cubit/inventory_cubit.dart';
import 'package:pharmacy_management/feature/Sales/presentaion/controlers/sale%20bloc/sale_cubit.dart';
import 'package:pharmacy_management/feature/dashboard/presentaion/controlers/dashboard_bubit/dashboard_cubit.dart';
import 'package:pharmacy_management/navigation_screen.dart';
import 'package:pharmacy_management/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (_) => di.sl<AuthCubit>()),
        BlocProvider<MedicienMangmentBloc>(
          create: (_) => MedicienMangmentBloc(
            addUsecase: di.sl(),
            deleteUsecase: di.sl(),
            detailsUsecase: di.sl(),
            editeUsecase: di.sl(),
            searchUsecase: di.sl(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
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
        "/login": (context) => const Login(),

        "/navigation": (context) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  DashboardCubit(getDashBoardDataUseCase: di.sl()),
            ),
            BlocProvider(
              create: (context) => SaleCubit(
                getSaleDetailsUsecase: di.sl(),
                getSalesUsecase: di.sl(),
              ),
            ),
            BlocProvider(
              create: (context) => InventoryCubit(
                getAlaretUsecase: di.sl(),
                updatequantityUsecase: di.sl(),
              ),
            ),
          ],
          child: const NavigationScreen(),
        ),
      },
      initialRoute: "/splash",
    );
  }
}
