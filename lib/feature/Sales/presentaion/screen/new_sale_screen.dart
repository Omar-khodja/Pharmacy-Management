import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_management/core/controler/medicien_mangment_bloc/medicien_mangment_bloc.dart';
import 'package:pharmacy_management/core/controler/medicien_mangment_bloc/medicien_mangment_bloc_event.dart';
import 'package:pharmacy_management/core/entities/medicien.dart';

import 'package:pharmacy_management/core/widget/search_widget.dart';
import 'package:pharmacy_management/feature/Sales/presentaion/new_sale_cubit.dart/new_sale_cubit.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New Sale")),
      body: Stack(children: [const SearchWidget(showEditButton: false)]),
    );
  }
}
