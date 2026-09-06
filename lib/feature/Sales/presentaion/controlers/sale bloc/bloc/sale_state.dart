part of 'sale_bloc.dart';

sealed class SaleState extends Equatable {
  const SaleState();

  @override
  List<Object> get props => [];
}

final class SaleLoding extends SaleState {}

final class SaleListData extends SaleState {
  final List<SaleEntity> sales;
  final String? errorMessage;
  const new({required this.sales, this.errorMessage});
}

