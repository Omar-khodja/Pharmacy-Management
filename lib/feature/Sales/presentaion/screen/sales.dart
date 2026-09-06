import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharmacy_management/feature/Sales/presentaion/controlers/sale%20bloc/bloc/sale_bloc.dart';
import 'package:pharmacy_management/feature/Sales/presentaion/widget/Invoice_card.dart';

class Sales extends StatefulWidget {
  const Sales({super.key});

  @override
  State<Sales> createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  @override
  void initState() {
    super.initState();
    context.read<SaleBloc>().add(GetSalesList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SaleBloc, SaleState>(
        listener: (context, state) {
          if (state is SaleListData) {
            if (state.errorMessage != null) {
              Fluttertoast.showToast(
                msg: state.errorMessage!,
                backgroundColor: Colors.red,
              );
            }
          }
        },
        builder: (context, state) {
          return switch (state) {
            SaleListData() =>
              state.sales.isEmpty
                  ? const Center(child: Text("No Invoice Yet!"))
                  : ListView.builder(
                      itemCount: state.sales.length,
                      itemBuilder: (context, index) {
                        return InvoiceCard(sale: state.sales[index]);
                      },
                    ),
            SaleLoding() => const Center(child: CircularProgressIndicator()),
          };
        },
      ),
    );
  }
}
