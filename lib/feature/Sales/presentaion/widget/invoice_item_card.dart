import 'package:flutter/material.dart';
import 'package:pharmacy_management/feature/Sales/domain/entities/sale_item.dart';

class InvoiceItemCard extends StatelessWidget {
  const InvoiceItemCard({super.key,required this.item});
  final SaleItem item;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainer,
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: [
            Text(
             item.medicineName,
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                const Icon(Icons.medical_services, color: Colors.blue),
                const SizedBox(width: 6),
                Text("Quantity: ${item.quantity}  ${item.medicine.unit}"),
              ],
            ),
            const SizedBox(height: 8,),

            Row(
              children: [
                const Icon(Icons.attach_money, color: Colors.green),
                const SizedBox(width: 6),
                Text("Unit Price: \$${item.unitPrice.toStringAsFixed(2)}"),
              ],
            ),

             Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                 const Text(
                  "Total:",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                 const SizedBox(width: 8,),
                Text(
                  "${item.total.toStringAsFixed(2)} DZ",
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    
  }
}
