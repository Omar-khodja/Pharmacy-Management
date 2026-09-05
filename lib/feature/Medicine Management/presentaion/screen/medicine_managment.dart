import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharmacy_management/core/entities/medicien.dart';
import 'package:pharmacy_management/core/widget/medicien_card_info.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/presentaion/controlers/category_cubit/category_cubit.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/presentaion/controlers/medicien_mangment_bloc/medicien_mangment_bloc.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/presentaion/controlers/medicien_mangment_bloc/medicien_mangment_bloc_event.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/presentaion/controlers/medicien_mangment_bloc/medicien_mangment_bloc_state.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/presentaion/screen/add_medicien_form.dart';
import 'package:pharmacy_management/core/dependnce_injection/injection_container.dart'
    as di;
import 'package:skeletonizer/skeletonizer.dart';

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

  Timer? _debounce;
  void _onSearchChange(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.trim().isNotEmpty) {
        context.read<MedicienMangmentBloc>().add(SearchMedicinesEvent(query));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
                    BlocProvider.value(
                      value: context.read<MedicienMangmentBloc>(),
                    ),
                  ],
                  child: const AddMedicienForm(),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
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
                  _onSearchChange(value);
                },
              ),
            ),

            Expanded(
              child:
                  BlocConsumer<MedicienMangmentBloc, MedicienMangmentBlocState>(
                    listener: (context, state) {
                      if (state is MedicienErrorState) {
                        Fluttertoast.showToast(
                          msg: state.errorMessage,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                        );
                      }
                      if (state is SuccessfulMessageState) {
                        Fluttertoast.showToast(msg: state.message);
                      }
                    },
                    builder: (context, state) {
                      if (state is MedicienLoadingState) {
                        return Skeletonizer(
                          child: ListView.builder(
                            itemCount: 3,
                            itemBuilder: (context, index) =>
                                MedicienCardInfo(medicine: Medicine.empty()),
                          ),
                        );
                      } else if (state is MedicienLoadedState) {
                        if (state.medicines.isEmpty) {
                          return const Center(child: Text("No Result Found"));
                        }
                        return BlocProvider.value(
                          value: context.read<MedicienMangmentBloc>(),
                          child: ListView.builder(
                            itemCount: state.medicines.length,
                            itemBuilder: (context, index) => MedicienCardInfo(
                              medicine: state.medicines[index],
                              showButtons: true,
                            ),
                          ),
                        );
                      } else if (state is MedicienErrorState) {
                        return Center(child: Text(state.errorMessage));
                      } else if (state is SuccessfulMessageState) {
                        if (state.medicines.isEmpty) {
                          return const Center(child: Text("No Result Found"));
                        }
                        return BlocProvider.value(
                          value: context.read<MedicienMangmentBloc>(),
                          child: ListView.builder(
                            itemCount: state.medicines.length,
                            itemBuilder: (context, index) => MedicienCardInfo(
                              medicine: state.medicines[index],
                              showButtons: true,
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
