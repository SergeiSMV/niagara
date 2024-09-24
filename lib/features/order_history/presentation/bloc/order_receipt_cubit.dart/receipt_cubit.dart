import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/order_history/domain/models/order_receipt.dart';
import 'package:niagara_app/features/order_history/domain/use_cases/get_order_receipt_use_case.dart';

part 'receipt_state.dart';
part 'receipt_cubit.freezed.dart';

@injectable
class OrderReceiptCubit extends Cubit<OrderReceiptState> {
  OrderReceiptCubit(
    this._getOrderReceiptUseCase,
  ) : super(const OrderReceiptState.initial());

  final GetOrderReceiptUseCase _getOrderReceiptUseCase;

  Future<void> getOrderReceipt(String orderId) async {
    emit(const OrderReceiptState.loading());

    await _getOrderReceiptUseCase(orderId).fold(
      (err) => emit(const OrderReceiptState.error()),
      (data) => emit(OrderReceiptState.loaded(orderReceipt: data)),
    );
  }
}
