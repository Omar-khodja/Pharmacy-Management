import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharmacy_management/core/controler/auth_cubit/auth_cubit.dart';
import 'package:pharmacy_management/core/controler/auth_cubit/auth_cubit_state.dart';
import 'package:pharmacy_management/feature/dashboard/presentaion/controlers/dashboard_bubit/dashboard_cubit.dart';
import 'package:pharmacy_management/feature/dashboard/presentaion/controlers/dashboard_bubit/dashboard_cubit_state.dart';
import 'package:pharmacy_management/feature/dashboard/presentaion/widget/dashboard_info_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardCubit>().getDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocListener<AuthCubit, AuthCubitState>(
          listener: (context, state) {
            if (mounted && state is AuthLoggedOut) {
              Fluttertoast.showToast(
                msg: "Logged out successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.red,
                textColor: Colors.white,
              );
              Navigator.pushReplacementNamed(context, "/login");
            }
            if (mounted && state is AuthFailure) {
              Fluttertoast.showToast(
                msg: state.message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.red,
                textColor: Colors.white,
              );
              if (state.statusCode == 401) {
                Navigator.pushReplacementNamed(context, "/login");
              }
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<DashboardCubit, DashboardCubitState>(
              builder: (context, state) {
                return switch (state) {
                  DashboardLoadingState() => const Skeletonizer(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  DashboardLoadedState(dashboardData: final dashboardData) =>
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,

                      children: [
                        DashboardInfoCard(
                          title: "Total Medicines",
                          value: dashboardData.totalMedicines.toString(),
                          icon: Icons.medication,
                        ),

                        DashboardInfoCard(
                          title: "Low Stock Medicines",
                          value: dashboardData.lowStockMedicines.length
                              .toString(),
                          icon: Icons.warehouse,
                          backgroundColor: Color(0xFFF5C6CB),
                        ),

                        ElevatedButton(
                          onPressed: () {
                            context.read<AuthCubit>().logout();
                          },
                          child: const Text("Logout"),
                        ),
                      ],
                    ),
                  DashboardFailureState(message: final message) => Center(
                    child: Text(
                      message,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                };
              },
            ),
          ),
        ),
      ),
    );
  }
}
