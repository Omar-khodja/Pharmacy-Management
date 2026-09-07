import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharmacy_management/core/controler/medicien_mangment_bloc/medicien_mangment_bloc.dart';
import 'package:pharmacy_management/feature/Sales/presentaion/controlers/sale%20bloc/sale_bloc.dart';
import 'package:pharmacy_management/feature/Sales/presentaion/new_sale_cubit.dart/new_sale_cubit.dart';
import 'package:pharmacy_management/feature/Sales/presentaion/screen/new_sale_screen.dart';
import 'package:pharmacy_management/feature/Sales/presentaion/widget/Invoice_card.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:pharmacy_management/core/dependnce_injection/injection_container.dart'
    as di;

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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: context.read<MedicienMangmentBloc>(),
                  ),
                  BlocProvider(
                    create: (context) =>
                        NewSaleCubit(createSaleUsecase: di.sl()),
                  ),
                ],

                child: const NewSaleScreen(),
              ),
            ),
          );
        },
        label: const Row(
          mainAxisSize: .min,
          children: [Text("New Sale"), Icon(Icons.add)],
        ),
        heroTag: "newSales",
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          debugPrint("hello");
          context.read<SaleBloc>().add(GetSalesList());
        },
        child: BlocConsumer<SaleBloc, SaleState>(
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
                          return InvoiceCard(
                            sale: state.sales[index],
                            showButton: true,
                          );
                        },
                      ),
              SaleLoding() => const Skeletonizer(
                child: Column(
                  children: [
                    ListTile(title: Text("data"), subtitle: Text("data")),
                    ListTile(title: Text("data"), subtitle: Text("data")),
                    ListTile(title: Text("data"), subtitle: Text("data")),
                  ],
                ),
              ),
            };
          },
        ),
      ),
    );
  }
}
