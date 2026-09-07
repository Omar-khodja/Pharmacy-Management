part of 'sale_bloc.dart';

sealed class SaleEvent extends Equatable {
  const SaleEvent();

  @override
  List<Object> get props => [];
}

final class GetSalesList extends SaleEvent {}



