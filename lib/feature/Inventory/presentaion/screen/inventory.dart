import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_management/feature/Inventory/presentaion/controlers/inventory_cubit/cubit/inventory_cubit.dart';
import 'package:pharmacy_management/feature/Inventory/presentaion/screen/Inventory_details.dart';
import 'package:pharmacy_management/core/widget/dashbord_card_info.dart';
import 'package:pharmacy_management/core/widget/error_messag.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Inventory extends StatefulWidget {
  const Inventory({super.key});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  @override
  void initState() {
    super.initState();
    context.read<InventoryCubit>().getAlaret();
  }

  void _onSave(int id, int quantity) {
    context.read<InventoryCubit>().updateQuntity(id, quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
      child: BlocBuilder<InventoryCubit, InventoryState>(
        builder: (context, state) {
          return switch (state) {
            InventoryLoding() => const Skeletonizer(
              child: Column(
                children: [
                  DashboardInfoCard(
                    title: "titile",
                    value: "0",
                    icon: Icons.abc,
                  ),
                      DashboardInfoCard(
                    title: "titile",
                    value: "0",
                    icon: Icons.abc,
                  ),
                ],
              ),
            ),
            Inventorydata() => Column(
              mainAxisAlignment: .start,
              children: [
                DashboardInfoCard(
                  title: "Low Stock Alaret",
                  value: state.alaret.lowStock.length.toString(),
                  icon: Icons.warehouse,
                  isError: state.alaret.lowStock.isNotEmpty,
                  ontap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => InventoryDetails(
                        medecine: state.alaret.lowStock,
                        title: "Low Stock Alaret",
                        postSave: (id, quantity) => _onSave(id, quantity),
                      ),
                    ),
                  ),
                ),
                DashboardInfoCard(
                  title: "Expiring Soon",
                  value: state.alaret.expiredSoon.length.toString(),
                  icon: Icons.warning,
                  isError: state.alaret.expiredSoon.isNotEmpty,
                  ontap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => InventoryDetails(
                        medecine: state.alaret.expiredSoon,
                        title: "Expiring Soon",
                        postSave: (id, quantity) => _onSave(id, quantity),
                      ),
                    ),
                  ),
                ),
                DashboardInfoCard(
                  title: "Expired",
                  value: state.alaret.expired.length.toString(),
                  icon: Icons.error,
                  isError: state.alaret.expired.isNotEmpty,
                  ontap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => InventoryDetails(
                        medecine: state.alaret.expired,
                        title: "Expired",
                        postSave: (id, quantity) => _onSave(id, quantity),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            InventoryError() => ErrorMessag(
              message: state.message!,
              onRetry: () {
                context.read<InventoryCubit>().getAlaret();
              },
            ),
          };
        },
      ),
    );
  }
}
