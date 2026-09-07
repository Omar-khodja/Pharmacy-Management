import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_management/feature/Sales/domain/entities/sale_entity.dart';
import 'package:pharmacy_management/feature/Sales/domain/usecase/get_sale_details_usecase.dart';
import 'package:pharmacy_management/feature/Sales/domain/usecase/get_sales_usecase.dart';

part 'sale_event.dart';
part 'sale_state.dart';

class SaleBloc extends Bloc<SaleEvent, SaleState> {
  final GetSaleDetailsUsecase getSaleDetailsUsecase;
  final GetSalesUsecase getSalesUsecase;
  SaleBloc({required this.getSaleDetailsUsecase, required this.getSalesUsecase})
    : super(SaleLoding()) {
    on<GetSalesList>((event, emit) async {
      final response = await getSalesUsecase.call();
      response.fold(
        ifLeft: (message) =>
            emit(SaleListData(sales: const [], errorMessage: message.message)),
        ifRight: (sales) {
          emit(SaleListData(sales: sales));
        },
      );
    });

  }
}
