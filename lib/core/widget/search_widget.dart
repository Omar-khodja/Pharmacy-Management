import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharmacy_management/core/controler/medicien_mangment_bloc/medicien_mangment_bloc.dart';
import 'package:pharmacy_management/core/controler/medicien_mangment_bloc/medicien_mangment_bloc_event.dart';
import 'package:pharmacy_management/core/controler/medicien_mangment_bloc/medicien_mangment_bloc_state.dart';
import 'package:pharmacy_management/core/entities/medicien.dart';
import 'package:pharmacy_management/core/widget/medicien_card_info.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({
    super.key,
    required this.showEditButton,
     this.onItemSelected,
  });
  final bool showEditButton;
  final void Function(Medicine)? onItemSelected;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  Timer? _debounce;
  void _onSearchChange(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<MedicienMangmentBloc>().add(SearchMedicinesEvent(query));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
          child: BlocConsumer<MedicienMangmentBloc, MedicienMangmentBlocState>(
            listener: (context, state) {
              if (state is MedicienLoadedState) {
                if (state.errorMessage != null) {
                  Fluttertoast.showToast(
                    msg: state.errorMessage!,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                  );
                }
                if (state.message != null) {
                  Fluttertoast.showToast(msg: state.message!);
                }
              }
            },
            builder: (context, state) {
              return switch (state) {
                MedicienLoadedState() =>
                  state.medicines.isEmpty
                      ? const Center(child: Text("No Result Found"))
                      : BlocProvider.value(
                          value: context.read<MedicienMangmentBloc>(),
                          child: ListView.builder(
                            itemCount: state.medicines.length,
                            itemBuilder: (context, index) => MedicienCardInfo(
                              medicine: state.medicines[index],
                              showButtons: widget.showEditButton,
                            ),
                          ),
                        ),
                MedicienLoadingState() => Skeletonizer(
                  child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) =>
                        MedicienCardInfo(medicine: Medicine.empty()),
                  ),
                ),
                MedicieninitState() => const Center(child: Text("Search for Medicien"),),
              };
            },
          ),
        ),
      ],
    );
  }
}
