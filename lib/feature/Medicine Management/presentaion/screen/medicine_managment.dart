import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pharmacy_management/feature/Medicine%20Management/presentaion/controlers/category_cubit/category_cubit.dart';
import 'package:pharmacy_management/core/controler/medicien_mangment_bloc/medicien_mangment_bloc.dart';
import 'package:pharmacy_management/core/controler/medicien_mangment_bloc/medicien_mangment_bloc_event.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/presentaion/screen/add_medicien_form.dart';
import 'package:pharmacy_management/core/dependnce_injection/injection_container.dart'
    as di;
import 'package:pharmacy_management/core/widget/search_widget.dart';

class MedicineManagement extends StatefulWidget {
  const MedicineManagement({super.key});

  @override
  State<MedicineManagement> createState() => _MedicineManagementState();
}

class _MedicineManagementState extends State<MedicineManagement> {
  @override
  void initState() {
    super.initState();
    context.read<MedicienMangmentBloc>().add(const SearchMedicinesEvent(" "));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final medicienBloc = context.read<MedicienMangmentBloc>();
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: 16,
                  right: 16,
                  top: 16,
                ),
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) =>
                          CategoryCubit(getCategoryUseCase: di.sl()),
                    ),
                    BlocProvider.value(value: medicienBloc),
                  ],
                  child: const AddMedicienForm(),
                ),
              );
            },
          );
        },
        heroTag: "NewMedicien",
        child: const Icon(Icons.add),
      ),
      body: const SafeArea(child: SearchWidget(showEditButton: true,)),
    );
  }
}
