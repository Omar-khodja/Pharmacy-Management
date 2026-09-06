import 'package:flutter/material.dart';
import 'package:pharmacy_management/feature/Sales/domain/entities/sale_entity.dart';
import 'package:pharmacy_management/feature/Sales/presentaion/screen/sale_details_screen.dart';

class InvoiceCard extends StatelessWidget {
  const InvoiceCard({super.key, required this.sale,required this.showButton});
  final SaleEntity sale;
  final bool showButton;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Theme.of(context).colorScheme.surfaceContainer,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sale.invoiceNumber,
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    sale.status,
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if(showButton)
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SaleDetailsScreen(sale: sale),
                      ),
                    );
                  },
                  icon: const Icon(Icons.keyboard_arrow_right),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.grey.withValues(alpha: .2),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  child: Text(
                    sale.cashier.name.substring(0, 2).toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sale.cashier.name,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      sale.createdAt.toString().substring(0, 10),
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            Chip(
              backgroundColor: Colors.grey.withValues(alpha: .2),
              label: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.attach_money, color: Colors.green),
                      const SizedBox(width: 6),
                      Text(
                        "${sale.paymentMethod} • Subtotal: ${sale.subtotal.toStringAsFixed(0)} DZ",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ],
                  ),
                  Text(
                    "${sale.total.toStringAsFixed(0)} DZ",
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
