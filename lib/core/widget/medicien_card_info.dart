import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_management/core/entities/medicien.dart';
import 'package:pharmacy_management/feature/dashboard/presentaion/widget/bedge.dart';

class MedicienCardInfo extends StatelessWidget {
  const MedicienCardInfo({super.key, required this.medicine});
  final Medicine medicine;
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
                    color:
                        medicine.isExpiringSoon
                        ? Colors.orange
                        : medicine.isExpired || medicine.isLowStock 
                        ? Colors.red
                        : Colors.green,
                  ),
                ),
                Text(
                  "Qty: ${medicine.quantity}",
                  style:  TextStyle(fontSize: 14, color: medicine.isLowStock?Colors.red: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              "Category: ${medicine.category.name}",
              style: const TextStyle(color: Colors.black87),
            ),

            Text(
              "Expiry: ${DateFormat("yyyy-mm-dd").format(medicine.expiryDate)}",
              style: TextStyle(
                color: medicine.isExpiringSoon
                    ? Colors.orange
                    : medicine.isExpired
                    ? Colors.red
                    : Colors.green,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: .start,
              children: [
                if (medicine.isExpiringSoon)
                  const Bedge(
                    title: "Expiring Soon",
                    icon: Icons.access_time,
                    color: Colors.orange,
                  ),
                const SizedBox(width: 12),
                if (medicine.isLowStock)
                  const Bedge(
                    title: "low Quntity",
                    icon: Icons.warning,
                    color: Colors.red,
                  ),
                if (medicine.isExpired)
                  const Bedge(
                    title: "Expired",
                    icon: Icons.warning,
                    color: Colors.red,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
