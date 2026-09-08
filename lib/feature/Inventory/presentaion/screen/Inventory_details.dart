import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharmacy_management/core/entities/medicien.dart';
import 'package:pharmacy_management/core/widget/medicien_card_info.dart';

class InventoryDetails extends StatefulWidget {
  const InventoryDetails({
    super.key,
    required this.medecine,
    required this.title,
    required this.postSave,
  });
  final String title;
  final List<Medicine> medecine;
  final void Function(int, int) postSave;

  @override
  State<InventoryDetails> createState() => _InventoryDetailsState();
}

class _InventoryDetailsState extends State<InventoryDetails> {
  final TextEditingController _quantity = TextEditingController();
  @override
  void dispose() {
    _quantity.dispose();
    super.dispose();
  }

  void _onSave(int id, int index) {
    final quantity = int.parse(_quantity.text);
    if (quantity < 0) {
      Fluttertoast.showToast(msg: "Quantity can't be less then 0");
      return;
    }
    _quantity.clear();
    setState(() {
      widget.medecine[index] = widget.medecine[index].copyWith(
        quantity: quantity,
      );
    });
    widget.postSave(id, quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: widget.medecine.isEmpty
          ? const Center(child: Text("Empty List"))
          : ListView.builder(
              itemCount: widget.medecine.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Update Quantity"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text("Enter a new quantity value:"),
                            const SizedBox(height: 12),
                            TextField(
                              controller: _quantity,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: "New Quantity",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text("Cancel"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _onSave(widget.medecine[index].id!, index);
                              Navigator.of(context)
                                  .pop(); // close dialog after update
                            },
                            child: const Text("Update"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: MedicienCardInfo(medicine: widget.medecine[index]),
              ),
            ),
    );
  }
}
