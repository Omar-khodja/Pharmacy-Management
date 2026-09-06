import 'package:pharmacy_management/feature/Sales/domain/entities/invoice.dart';

class InvoiceModel extends Invoice {
  new({required super.medicienId, required super.quantity});

   
  factory InvoiceModel.fromEntity(Invoice entity) {
    return InvoiceModel(
      medicienId: entity.medicienId,
      quantity: entity.quantity,
    );
  }

  Map<String, dynamic> toJson() {
    return {"medicine_id": medicienId, "quantity": quantity};
  }
}
