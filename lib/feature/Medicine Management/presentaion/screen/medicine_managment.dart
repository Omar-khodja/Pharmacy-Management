import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharmacy_management/core/widget/medicien_card_info.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/presentaion/controlers/medicien_mangment_bloc/medicien_mangment_bloc.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/presentaion/controlers/medicien_mangment_bloc/medicien_mangment_bloc_event.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/presentaion/controlers/medicien_mangment_bloc/medicien_mangment_bloc_state.dart';

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
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search medicines...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                  ),
                ),
                onChanged: (value) {
                  context.read<MedicienMangmentBloc>().add(
                    SearchMedicinesEvent(value),
                  );
                },
              ),
            ),

            Expanded(
              child:
                  BlocConsumer<MedicienMangmentBloc, MedicienMangmentBlocState>(
                    listener: (context, state) {
                      if (state is MedicienErrorState) {
                        Fluttertoast.showToast(msg: state.errorMessage);
                      }
                    },
                    builder: (context, state) {
                      return switch (state) {
                        MedicieninitState() => const Center(
                          child: Text("Start typing to search medicines..."),
                        ),
                        MedicienLoadedState(medicines: final medicines) =>
                          ListView.builder(
                            itemCount: medicines.length,
                            itemBuilder: (context, index) =>
                                MedicienCardInfo(medicine: medicines[index]),
                          ),
                        MedicienLoadingState() => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        SuccessfulMessageState(message: final message) =>
                          Center(child: Text(message)),
                        MedicienErrorState(errorMessage: final errorMessage) =>
                          Center(child: Text(errorMessage)),
                      };
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
