import 'package:flutter/material.dart';
import 'package:pharmacy_management/feature/Sales/domain/entities/sale_entity.dart';
import 'package:pharmacy_management/feature/Sales/presentaion/widget/Invoice_card.dart';
import 'package:pharmacy_management/feature/Sales/presentaion/widget/invoice_item_card.dart';

class SaleDetailsScreen extends StatelessWidget {
  const SaleDetailsScreen({super.key, required this.sale});
  final SaleEntity sale;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Invoice Details")),
      body: Column(
        mainAxisAlignment: .start,
        crossAxisAlignment: .start,
        children: [
          InvoiceCard(sale: sale, showButton: false),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
            child: Text(
              "Medicien from Invoice",
              style: Theme.of(context).textTheme.titleLarge!
                  .copyWith(fontWeight: .bold),
            ),
          ),
          const SizedBox(height: 8),
          const Divider(thickness: 0.5, color: Colors.grey),

          const SizedBox(height: 8),
          if (sale.items != null)
            Expanded(
              child: ListView.builder(
                itemCount: sale.items!.length,
                itemBuilder: (context, index) =>
                    InvoiceItemCard(item: sale.items![index]),
              ),
            ),
        ],
      ),
    );
  }
}
