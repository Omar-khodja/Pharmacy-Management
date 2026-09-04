import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<MedicienMangmentBloc, MedicienMangmentBlocState>(
          listener: (context, state) {
            if (state is MedicienError) {
              Fluttertoast.showToast(msg: state.errorMessage);
            }
          },
          builder: (context, state) => Column(
            mainAxisAlignment: .start,
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
            ],
          ),
        ),
      ),
    );
  }
}
