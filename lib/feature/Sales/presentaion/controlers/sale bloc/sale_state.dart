part of 'sale_bloc.dart';

sealed class SaleState extends Equatable {
  const SaleState();

  @override
  List<Object> get props => [];
}

final class SaleLoding extends SaleState {}

final class SaleListData extends SaleState {
  final List<SaleEntity> sales;
  const new({required this.sales});
}

final class SaleError extends SaleState {
  final String errorMessage;
  const new(this.errorMessage);
}

