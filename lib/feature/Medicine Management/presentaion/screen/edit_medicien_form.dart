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

  class EditMedicienForm extends StatefulWidget {
    const EditMedicienForm({super.key, required this.medicine});
    final Medicine medicine;
    @override
    State<EditMedicienForm> createState() => _EditMedicienFormState();
  }

  class _EditMedicienFormState extends State<EditMedicienForm> {
    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController();
    final _priceController = TextEditingController();
    final _expiryDate = TextEditingController();
    Category? _slectedCategory;
    @override
    void initState() {
      super.initState();
      context.read<CategoryCubit>().getCategory();
      final data = widget.medicine;

      _nameController.text = data.name;
      _expiryDate.text = data.expiryDate.toIso8601String();
      _priceController.text = data.price.toString();
      _slectedCategory = data.category;
    }

    @override
    void dispose() {
      super.dispose();
      _nameController.dispose();
      _priceController.dispose();
      _expiryDate.dispose();
    }

    void _onSave() {
      final data = widget.medicine;
      if (_formKey.currentState!.validate() && _slectedCategory != null) {
        final medicineData = Medicine(
          id: data.id,
          name: _nameController.text,
          categoryId: _slectedCategory!.id,
          category: _slectedCategory,
          price: double.tryParse(_priceController.text)!,
          quantity: data.quantity,
          expiryDate: DateTime.parse(_expiryDate.text),
          
        );
        context.read<MedicienMangmentBloc>().add(EditMedicineEvent(medicineData));
        Navigator.of(context).pop();
      }
    }

    @override
    Widget build(BuildContext context) {
      final data = widget.medicine;
      final height = MediaQuery.of(context).size.height;
      return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: .center,
            children: [
              const Text(
                "Edite Medicine",
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
                initialValue: data.quantity.toString(),
                readOnly: true,
                decoration: const InputDecoration(labelText: "Quantity"),
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
                      initialValue: data.category,
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
                  debugPrint("/////////////////////////////////////////////hola");
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
