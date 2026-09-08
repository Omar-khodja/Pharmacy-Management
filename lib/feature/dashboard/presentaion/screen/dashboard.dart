import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_management/core/widget/error_messag.dart';
import 'package:pharmacy_management/feature/dashboard/domain/entities/low_stock_medicien.dart';
import 'package:pharmacy_management/feature/dashboard/presentaion/controlers/dashboard_bubit/dashboard_cubit.dart';
import 'package:pharmacy_management/feature/dashboard/presentaion/controlers/dashboard_bubit/dashboard_cubit_state.dart';
import 'package:pharmacy_management/core/widget/dashbord_card_info.dart';
import 'package:pharmacy_management/feature/dashboard/presentaion/widget/low_stok_medicien_card.dart';
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
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: BlocBuilder<DashboardCubit, DashboardCubitState>(
            builder: (context, state) {
              return switch (state) {
                DashboardLoadingState() => Skeletonizer(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: .start,

                    children: [
                      const DashboardInfoCard(
                        title: "Total Medicines",
                        value: "2027/28/80",
                        icon: Icons.medication,
                      ),

                      const DashboardInfoCard(
                        title: "Low Stock Medicines",
                        value: "5",
                        icon: Icons.warehouse,
                        isError: true,
                      ),
                      const DashboardInfoCard(
                        title: "Total Medicines",
                        value: "2027/28/80",
                        icon: Icons.medication,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Recent Alerts",
                        style: TextStyle(fontSize: 18, fontWeight: .bold),
                      ),
                      const Divider(color: Colors.grey),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            final medicine = LowStockMedicien.empty();

                            return LowStokMedicienCard(medicine: medicine);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                DashboardLoadedState(dashboardData: final dashboardData) =>
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: .start,

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
                        isError: true,
                      ),
                      DashboardInfoCard(
                        title: "Today Sales",
                        value: "${dashboardData.salesData.total.toString()} DZ",
                        icon: Icons.attach_money,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Recent Alerts",
                        style: TextStyle(fontSize: 18, fontWeight: .bold),
                      ),
                      const Divider(color: Colors.grey),
                      Expanded(
                        child: ListView.builder(
                          itemCount:
                              state.dashboardData.lowStockMedicines.length,
                          itemBuilder: (context, index) {
                            final medicine =
                                state.dashboardData.lowStockMedicines[index];
                            return LowStokMedicienCard(medicine: medicine);
                          },
                        ),
                      ),
                    ],
                  ),
                DashboardFailureState(message: final message) => ErrorMessag(
                  message: message,
                  onRetry: () =>
                      context.read<DashboardCubit>().getDashboardData(),
                )
              };
            },
          ),
        ),
      ),
    );
  }
}
