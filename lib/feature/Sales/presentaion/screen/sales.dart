import 'package:flutter/material.dart';

class Sales extends StatefulWidget {
  const Sales({super.key});

  @override
  State<Sales> createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Sales",
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }
}