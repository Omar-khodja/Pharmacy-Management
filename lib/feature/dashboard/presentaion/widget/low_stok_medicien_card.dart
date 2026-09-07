import 'package:flutter/material.dart';
import 'package:pharmacy_management/core/widget/Textbedge.dart';
import 'package:pharmacy_management/feature/dashboard/domain/entities/low_stock_medicien.dart';

class LowStokMedicienCard extends StatelessWidget {
  const LowStokMedicienCard({super.key, required this.medicine});
  final LowStockMedicien medicine;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainer,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 3,
      child: ListTile(
        title: Text(
          medicine.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("Quantity: ${medicine.quantity}"),
        trailing: const TextBedge(
          title: "low Quntity",
          icon: Icons.warning,
          color: Colors.red,
        ),
      ),
    );
  }
}
