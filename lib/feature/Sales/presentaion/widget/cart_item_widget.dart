import 'package:flutter/material.dart';
import 'package:pharmacy_management/core/entities/medicine.dart';

class CartItemWidget extends StatefulWidget {
  const CartItemWidget({
    super.key,
    required this.medicine,
    required this.decrement,
    required this.increment,
  });
  final void Function(int) increment;
   final void Function(int) decrement;
  final Medicine medicine;

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        padding:const  EdgeInsets.all(8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Theme.of(context).colorScheme.surfaceContainer ),
        child: Row(
            children: [
              Column(
                crossAxisAlignment: .start,
                mainAxisAlignment: .center,
              mainAxisSize: .min,
                children: [
                  Text(widget.medicine.name),
                  Text(
                    "Unit Price: ${widget.medicine.price} DZ",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                width: 132,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed:()=> widget.decrement(widget.medicine.id!),
                    ),
                    Text(
                      widget.medicine.orederedQuantity.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed:() {
                      debugPrint("here");  
                      widget.increment(widget.medicine.id!);
                      } 
                    ),
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }
}
