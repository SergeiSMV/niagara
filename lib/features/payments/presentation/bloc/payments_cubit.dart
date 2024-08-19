import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/payment_statuses.dart';
import 'package:niagara_app/features/order_placing/domain/models/tokenization_data.dart';
import 'package:niagara_app/features/payments/domain/use_cases/get_confirmation_url_use_case.dart';
import 'package:niagara_app/features/payments/domain/use_cases/get_payment_status_use_case.dart';
import 'package:niagara_app/features/payments/domain/use_cases/start_confirmation_use_case.dart';
import 'package:niagara_app/features/payments/domain/use_cases/start_tokenization_use_case.dart';

part 'payments_state.dart';
part 'payments_cubit.freezed.dart';

@injectable
class PaymentsCubit extends Cubit<PaymentsState> {
  PaymentsCubit(
    this._startTokenizationUseCase,
    this._getConfirmationUrlUseCase,
    this._startConfirmationUseCase,
    this._getPaymentStatusUseCase,
  ) : super(const PaymentsState.initial());

  final StartTokenizationUseCase _startTokenizationUseCase;
  final GetConfirmationUrlUseCase _getConfirmationUrlUseCase;
  final StartConfirmationUseCase _startConfirmationUseCase;
  final GetPaymentStatusUseCase _getPaymentStatusUseCase;

  int statusPollingAttempts = 0;
  Timer? pollingTimer;

  Future<void> startTokenization(TokenizationData data) async {
    await _startTokenizationUseCase(data).fold(
      (failure) => emit(const PaymentsState.tokenizationError()),
      (token) async {
        if (token == null) {
          return emit(const PaymentsState.tokenizationError());
        }

        await _getConfirmationUrlUseCase(
          GetConfirmationUrlParams(
            orderId: data.orderId,
            paymentToken: token,
          ),
        ).fold(
          (err) => emit(const PaymentsState.getConfirmationUrlError()),
          (info) async {
            if (info.confirmationUrl == null) {
              if (info.success) {
                return emit(const _Success());
              } else {
                return emit(const _Canceled());
              }
            }

            await _startConfirmationUseCase(
              StartConfirmationParams(
                clientKey: data.applicationKey,
                confirmationUrl: info.confirmationUrl!,
                paymentMethod: data.paymentMethod,
                shopId: data.shopId,
              ),
            ).fold(
              (err) => emit(const PaymentsState.confirmationError()),
              (_) => startPollingPaymentStatus(data.orderId),
            );
          },
        );
      },
    );
  }

  void startPollingPaymentStatus(String orderId) {
    emit(const PaymentsState.loading());

    pollingTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        if (statusPollingAttempts >= 30) {
          _killTimer();
          return emit(const PaymentsState.paymentStatusError());
        }

        await _getPaymentStatusUseCase(orderId).fold(
          (err) => emit(const PaymentsState.paymentStatusError()),
          (status) {
            if (status == PaymentStatus.succeeded) {
              _killTimer();
              emit(const PaymentsState.success());
            } else if (status == PaymentStatus.canceled) {
              _killTimer();
              emit(const PaymentsState.orderCanceled());
            }
          },
        );

        statusPollingAttempts++;
      },
    );
  }

  void _killTimer() {
    pollingTimer?.cancel();
    pollingTimer = null;
  }

  @override
  Future<void> close() {
    pollingTimer?.cancel();
    return super.close();
  }
}
