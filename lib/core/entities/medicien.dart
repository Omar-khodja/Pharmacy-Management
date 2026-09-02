import 'package:equatable/equatable.dart';
import 'package:pharmacy_management/core/entities/category.dart';

class Medicine extends Equatable {
  final int id;
  final String name;
  final int categoryId;
  final Category category;
  final double price;
  final int quantity;
  final int minStockLevel;
  final DateTime expiryDate;
  final String expiryStatus; 
  final bool isLowStock;
  final bool isExpired;
  final bool isExpiringSoon;


  const Medicine({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.category,
    required this.price,
    required this.quantity,
    required this.minStockLevel,
    required this.expiryDate,
    required this.expiryStatus,
    required this.isLowStock,
    required this.isExpired,
    required this.isExpiringSoon,

  });

  @override
  List<Object?> get props => [
        id,
        name,
        categoryId,
        category,
        price,
        quantity,
        minStockLevel,
        expiryDate,
        expiryStatus,
        isLowStock,
        isExpired,
        isExpiringSoon,
  
      ];
}
