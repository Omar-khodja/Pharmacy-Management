import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_management/core/entities/medicien.dart';
import 'package:pharmacy_management/core/widget/Textbedge.dart';
import 'package:pharmacy_management/core/widget/custom_iconbutton.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/presentaion/controlers/medicien_mangment_bloc/medicien_mangment_bloc.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/presentaion/controlers/medicien_mangment_bloc/medicien_mangment_bloc_event.dart';

class MedicienCardInfo extends StatelessWidget {
  const MedicienCardInfo({
    super.key,
    required this.medicine,
    this.showButtons = false,
  });
  final Medicine medicine;
  final bool showButtons;
  void _onDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: const Text("Are you sure you want to delete this Medicien?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              context.read<MedicienMangmentBloc>().add(
                DeleteMedicineEvent(medicine.id!),
              );
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  medicine.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: medicine.isExpiringSoon!
                        ? Colors.orange
                        : medicine.isExpired! || medicine.isLowStock!
                        ? Colors.red
                        : Colors.green,
                  ),
                ),
                Text(
                  "Qty: ${medicine.quantity}",
                  style: TextStyle(
                    fontSize: 14,
                    color: medicine.isLowStock! ? Colors.red : Colors.black54,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              "Category: ${medicine.category!.name}",
              style: const TextStyle(color: Colors.black87),
            ),

            Text(
              "Expiry: ${DateFormat("yyyy-mm-dd").format(medicine.expiryDate)}",
              style: TextStyle(
                color: medicine.isExpiringSoon!
                    ? Colors.orange
                    : medicine.isExpired!
                    ? Colors.red
                    : Colors.green,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: .start,
              children: [
                if (medicine.isExpiringSoon!)
                  const TextBedge(
                    title: "Expiring Soon",
                    icon: Icons.access_time,
                    color: Colors.orange,
                  ),
                const SizedBox(width: 12),
                if (medicine.isLowStock!)
                  const TextBedge(
                    title: "low Quntity",
                    icon: Icons.warning,
                    color: Colors.red,
                  ),
                if (medicine.isExpired!)
                  const TextBedge(
                    title: "Expired",
                    icon: Icons.warning,
                    color: Colors.red,
                  ),
              ],
            ),
            const SizedBox(height: 8),
            if (showButtons)
              Row(
                mainAxisAlignment: .end,
                children: [
                  CustomIconbutton(icon: Icons.edit_outlined, onTab: () {}),
                  const SizedBox(width: 8),
                  CustomIconbutton(
                    icon: Icons.delete_outline,
                    onTab: () => _onDelete(context),
                    color: Colors.red,
                    iconColor: Colors.white,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
