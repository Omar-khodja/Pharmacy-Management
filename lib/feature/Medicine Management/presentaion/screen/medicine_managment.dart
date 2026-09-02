import 'package:flutter/material.dart';

class MedicineManagement extends StatefulWidget {
  const MedicineManagement({super.key});

  @override
  State<MedicineManagement> createState() => _MedicineManagementState();
}

class _MedicineManagementState extends State<MedicineManagement> {
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