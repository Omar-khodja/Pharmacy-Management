import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_management/core/entities/category.dart';
import 'package:pharmacy_management/core/entities/medicien.dart';
import 'package:pharmacy_management/core/widget/primary_elevatedbutton.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/presentaion/controlers/category_cubit/category_cubit.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/presentaion/controlers/category_cubit/category_cubit_state.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/presentaion/controlers/medicien_mangment_bloc/medicien_mangment_bloc.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/presentaion/controlers/medicien_mangment_bloc/medicien_mangment_bloc_event.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AddMedicienForm extends StatefulWidget {
  const AddMedicienForm({super.key});
  @override
  State<AddMedicienForm> createState() => _AddMedicienFormState();
}

class _AddMedicienFormState extends State<AddMedicienForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _expiryDate = TextEditingController();
  Category? _slectedCategory;
  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().getCategory();
  }

  @override
  void dispose() {
    super.dispose();

    _nameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _expiryDate.dispose();
  }

  void _onSave() {
    if (_formKey.currentState!.validate() && _slectedCategory != null) {
      final medicineData = Medicine(
        name: _nameController.text,
        categoryId: _slectedCategory!.id,
        price: double.tryParse(_priceController.text)!,
        quantity: int.tryParse(_quantityController.text)!,
        expiryDate: DateFormat('yyyy/MM/dd').parse(_expiryDate.text),
      );
      context.read<MedicienMangmentBloc>().add(AddMedicineEvent(medicineData));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text(
              "Add New Medicine",
              style: TextStyle(fontSize: 28, fontWeight: .bold),
            ),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Name"),
              validator: (value) =>
                  value!.isEmpty ? "Enter medicine name" : null,
            ),
            TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: "Price"),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter a price";
                }
                final price = double.tryParse(value);
                if (price == null) {
                  return "Enter a valid number";
                }
                if (price <= 0) {
                  return "Price must be greater than 0";
                }
                return null;
              },
            ),

            TextFormField(
              controller: _quantityController,
              decoration: const InputDecoration(labelText: "Quantity"),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter a quantity";
                }
                final qty = int.tryParse(value);
                if (qty == null) {
                  return "Enter a valid integer";
                }
                if (qty <= 0) {
                  return "Quantity must be greater than 0";
                }
                return null;
              },
            ),

            TextFormField(
              controller: _expiryDate,
              readOnly: true,
              decoration: const InputDecoration(labelText: "Pick Expiry Date"),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  final formattedDate = DateFormat('yyyy/MM/dd').format(picked);
                  setState(() {
                    _expiryDate.text = formattedDate;
                  });
                }
              },
              validator: (value) => value == null || value.isEmpty
                  ? "Please pick an expiry date"
                  : null,
            ),
            BlocBuilder<CategoryCubit, CategoryCubitState>(
              builder: (context, state) {
                if (state is CategoryLoadedState) {
                  return DropdownButtonFormField<Category>(
                    items: state.category
                        .map(
                          (item) => DropdownMenuItem<Category>(
                            value: item,
                            child: Text("${item.name} / ${item.nameAr}"),
                          ),
                        )
                        .toList(),
                    onChanged: (val) => _slectedCategory = val,
                    decoration: const InputDecoration(labelText: "Category"),
                    validator: (val) =>
                        val == null ? "Select a category" : null,
                  );
                } else if (state is CategoryErrorState) {
                  Fluttertoast.showToast(msg: state.message);
                  return Center(child: Text(state.message));
                } else {
                  return const Skeletonizer(child: TextField());
                }
              },
            ),
            const SizedBox(height: 20),

            PrimaryElevatedbutton(
              title: "Save",
              onClick: () {
                _onSave();
              },
            ),
            SizedBox(height: height * 0.25),
          ],
        ),
      ),
    );
  }
}
