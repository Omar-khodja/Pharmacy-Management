import 'package:flutter/material.dart';

class MedicineManagment extends StatefulWidget {
  const MedicineManagment({super.key});

  @override
  State<MedicineManagment> createState() => _MedicineManagmentState();
}

class _MedicineManagmentState extends State<MedicineManagment> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Medicine Managment",
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }
}