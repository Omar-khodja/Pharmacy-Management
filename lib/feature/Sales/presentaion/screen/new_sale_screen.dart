import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharmacy_management/core/controler/medicien_mangment_bloc/medicien_mangment_bloc.dart';
import 'package:pharmacy_management/core/controler/medicien_mangment_bloc/medicien_mangment_bloc_event.dart';
import 'package:pharmacy_management/core/entities/medicien.dart';

import 'package:pharmacy_management/core/widget/search_widget.dart';
import 'package:pharmacy_management/feature/Sales/presentaion/new_sale_cubit.dart/new_sale_cubit.dart';
import 'package:pharmacy_management/feature/Sales/presentaion/new_sale_cubit.dart/new_sale_cubit_state.dart';
import 'package:pharmacy_management/feature/Sales/presentaion/widget/cart_item_widget.dart';

class NewSaleScreen extends StatefulWidget {
  const NewSaleScreen({super.key});

  @override
  State<NewSaleScreen> createState() => _NewSaleScreenState();
}

class _NewSaleScreenState extends State<NewSaleScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MedicienMangmentBloc>().add(const SearchMedicinesEvent(" "));
  }

  void _selectNewItem(Medicine item) {
    context.read<NewSaleCubit>().addToBasket(item);
  }

  void _increment(int id) {
    debugPrint("here");
    context.read<NewSaleCubit>().incrementQuantity(id);
  }

  void _decriment(int id) {
    context.read<NewSaleCubit>().decrementQuantity(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New Sale")),
      body: Stack(
        children: [
          SearchWidget(showEditButton: false, onItemSelected: _selectNewItem),
          Positioned(
            bottom: 8,
            left: 6,
            right: 6,
            child: BlocConsumer<NewSaleCubit, NewSaleCubitState>(
              listener: (context, state) {
                if (state is NewSaleData) {
                  if (state.errorMessage != null) {
                    Fluttertoast.showToast(msg: state.errorMessage!);
                  }
                }
              },
              builder: (context, state) => Card(
                color: Theme.of(context).colorScheme.surface,
                margin: const EdgeInsets.all(12),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: .min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Cart Items",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          itemCount: state.medicine.length,
                          itemBuilder: (context, index) {
                            final medicine = state.medicine[index];

                            return Dismissible(
                              key: ValueKey(medicine.id),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                color: Colors.red,
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              onDismissed: (_) {
                                context.read<NewSaleCubit>().removeFromBasket(
                                  medicine,
                                );
                              },
                              child: CartItemWidget(
                                medicine: medicine,
                                decrement: _decriment,
                                increment: _increment,
                              ),
                            );
                          },
                        ),
                      ),
                      const Divider(),
                      Text("Total items: ${state.medicine.length}"),
                      Text(
                        "Total price: ${state.medicine.fold<double>(0, (sum, m) => sum + (m.price * m.orederedQuantity))} DA",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
