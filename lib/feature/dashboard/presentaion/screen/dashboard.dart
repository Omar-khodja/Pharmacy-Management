import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_management/core/entities/medicien.dart';
import 'package:pharmacy_management/feature/dashboard/presentaion/controlers/dashboard_bubit/dashboard_cubit.dart';
import 'package:pharmacy_management/feature/dashboard/presentaion/controlers/dashboard_bubit/dashboard_cubit_state.dart';
import 'package:pharmacy_management/feature/dashboard/presentaion/widget/dashbord_card_info.dart';
import 'package:pharmacy_management/core/widget/medicien_card_info.dart';
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
                            final medicine = Medicine.empty();

                            return MedicienCardInfo(medicine: medicine);
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
                            return MedicienCardInfo(medicine: medicine);
                          },
                        ),
                      ),
                    ],
                  ),
                DashboardFailureState(message: final message) =>
                  RefreshIndicator(
                    onRefresh: () =>
                        context.read<DashboardCubit>().getDashboardData(),
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.7,
                          child: Center(
                            child: Text(
                              message,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              };
            },
          ),
        ),
      ),
    );
  }
}
