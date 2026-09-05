import 'package:equatable/equatable.dart';
import 'package:pharmacy_management/core/entities/category.dart';

class Medicine extends Equatable {
  final int? id;
  final String name;
  final int categoryId;
  final Category? category;
  final double price;
  final int quantity;
  final int? minStockLevel;
  final DateTime expiryDate;
  final String? expiryStatus;
  final bool? isLowStock;
  final bool? isExpired;
  final bool? isExpiringSoon;

  const Medicine({
    this.id,
    required this.name,
    required this.categoryId,
    this.category,
    required this.price,
    required this.quantity,
    this.minStockLevel,
    required this.expiryDate,
    this.expiryStatus,
    this.isLowStock,
    this.isExpired,
    this.isExpiringSoon,
  });
  factory Medicine.empty() {
    return Medicine(
      id: 0,
      name: '',
      categoryId: 0,
      category: const Category(id: 0, name: '', nameAr: ''),
      price: 0.0,
      quantity: 0,
      minStockLevel: 0,
      expiryDate: DateTime.now(),
      expiryStatus: '',
      isLowStock: false,
      isExpired: false,
      isExpiringSoon: false,
    );
  }
    /// ✅ CopyWith method
  Medicine copyWith({
    int? id,
    String? name,
    int? categoryId,
    Category? category,
    double? price,
    int? quantity,
    int? minStockLevel,
    DateTime? expiryDate,
    String? expiryStatus,
    bool? isLowStock,
    bool? isExpired,
    bool? isExpiringSoon,
  }) {
    return Medicine(
      id: id ?? this.id,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      category: category ?? this.category,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      minStockLevel: minStockLevel ?? this.minStockLevel,
      expiryDate: expiryDate ?? this.expiryDate,
      expiryStatus: expiryStatus ?? this.expiryStatus,
      isLowStock: isLowStock ?? this.isLowStock,
      isExpired: isExpired ?? this.isExpired,
      isExpiringSoon: isExpiringSoon ?? this.isExpiringSoon,
    );
  }

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
