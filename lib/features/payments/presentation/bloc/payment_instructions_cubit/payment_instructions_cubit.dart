import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/payment_error_type.dart';
import 'package:niagara_app/core/utils/enums/payment_statuses.dart';
import 'package:niagara_app/features/order_placing/domain/models/tokenization_data.dart';
import 'package:niagara_app/features/payments/domain/model/paument_confirmation_info.dart';
import 'package:niagara_app/features/payments/domain/use_cases/get_confirmation_url_use_case.dart';
import 'package:niagara_app/features/payments/domain/use_cases/get_payment_status_use_case.dart';
import 'package:niagara_app/features/payments/domain/use_cases/start_confirmation_use_case.dart';
import 'package:niagara_app/features/payments/domain/use_cases/start_tokenization_use_case.dart';

part 'payment_instructions_state.dart';
part 'payment_instructions_cubit.freezed.dart';

/// Кубит для управления процессом оплаты заказа.
///
/// Отвечает за сценарий платёжного процесса: запуск токенизации платежа,
/// получение ссылки на подтверждение платежа, запуск подтверждения платежа,
/// опрос статуса платежа.
@injectable
class PaymentInstructionsCubit extends Cubit<PaymentInstructionsState> {
  PaymentInstructionsCubit(
    this._startTokenizationUseCase,
    this._getConfirmationUrlUseCase,
    this._startConfirmationUseCase,
    this._getPaymentStatusUseCase,
  ) : super(const PaymentInstructionsState.initial());

  /// Кейс для запуска токенизации платежа.
  ///
  /// Вызывает модальное окно с введением платёжных данных.
  final StartTokenizationUseCase _startTokenizationUseCase;

  /// Кейс для получения ссылки на подтверждение платежа.
  final GetConfirmationUrlUseCase _getConfirmationUrlUseCase;

  /// Кейс для запуска подтверждения платежа.
  ///
  /// Открывает окно с формой подтверждения платежа.
  final StartConfirmationUseCase _startConfirmationUseCase;

  /// Кейс для получения статуса платежа.
  final GetPaymentStatusUseCase _getPaymentStatusUseCase;

  /// Количество попыток опроса статуса платежа.
  int _statusPollingAttempts = 0;

  /// Таймер для опроса статуса платежа.
  Timer? _pollingTimer;

  /// Запускает процесс оплаты заказа.
  ///
  /// Последовательность действий:
  /// 1. Запускается токенизация платежа. Пользователь видит модальное окно для
  /// ввода платежных данных.
  ///
  /// 2. Запрашивается информация о подтверждении платежа. Если платёж не
  /// требует  подтверждения, то сразу переходим к пункту 4.
  ///
  /// 3. Подтверждение платежа. Пользователь видит окно с формой подтверждения.
  ///
  /// 4. Платеж завершен успешно или с ошибкой.
  Future<void> startPayment(TokenizationData data) async {
    const PaymentInstructionsState.initial();

    // Запускаем токенизацию платежа.
    final String? paymentToken = await _startTokenization(data);
    if (paymentToken == null) return;

    // Получаем информацию о подтверждении платежа.
    final PaymentConfirmationInfo? confirmationInfo =
        await _getConfirmationInfo(data.orderId, paymentToken);
    if (confirmationInfo == null) return;

    // Запускаем процесс подтверждения платежа.
    final bool confirmationStarted =
        await _startConfirmation(data, confirmationInfo);
    if (!confirmationStarted) return;

    _startPollingPaymentStatus(data.orderId);
  }

  /// Запускает процесс токенизации платежа.
  Future<String?> _startTokenization(TokenizationData data) =>
      _startTokenizationUseCase(data).fold(
        (_) {
          emit(const _Error(type: PaymentErrorType.serviceUnavailable));
          return null;
        },
        (token) {
          if (token == null) {
            emit(const _Error(type: PaymentErrorType.notConfirmed));
          }
          return token;
        },
      );

  /// Запрашивает информацию о подтверждении платежа.
  Future<PaymentConfirmationInfo?> _getConfirmationInfo(
    String orderId,
    String paymentToken,
  ) {
    final getUrlParams = GetConfirmationUrlParams(
      orderId: orderId,
      paymentToken: paymentToken,
    );

    return _getConfirmationUrlUseCase(getUrlParams).fold(
      (err) {
        emit(const _Error(type: PaymentErrorType.notCreated));
        return null;
      },
      (info) {
        if (info.confirmationRequired) return info;

        if (info.status == PaymentStatus.succeeded) {
          emit(const PaymentInstructionsState.success());
        } else if (info.status == PaymentStatus.canceled) {
          emit(const PaymentInstructionsState.orderCanceled());
        }

        return null;
      },
    );
  }

  /// Запускает процесс подтверждения платежа.
  Future<bool> _startConfirmation(
    TokenizationData data,
    PaymentConfirmationInfo info,
  ) async {
    if (info.confirmationUrl == null) {
      emit(const _Error(type: PaymentErrorType.serviceUnavailable));
      return false;
    }

    final confirmationParams = StartConfirmationParams(
      clientKey: data.applicationKey,
      confirmationUrl: info.confirmationUrl!,
      paymentMethod: data.paymentMethod,
      shopId: data.shopId,
    );

    return _startConfirmationUseCase(confirmationParams).fold(
      (_) {
        emit(const _Error(type: PaymentErrorType.serviceUnavailable));
        return false;
      },
      (_) => true,
    );
  }

  /// Запускает опрос статуса платежа.
  void _startPollingPaymentStatus(String orderId) {
    emit(const PaymentInstructionsState.loading());

    _pollingTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        if (_statusPollingAttempts >= 30) {
          _killTimer();
          return emit(const _Error(type: PaymentErrorType.statusError));
        }

        if (isClosed || !timer.isActive) return;

        await _getPaymentStatusUseCase(orderId).fold(
          (err) {
            emit(const _Error(type: PaymentErrorType.statusError));
            _killTimer();
          },
          (status) {
            if (state is _Success || state is _Canceled) return;

            if (status == PaymentStatus.succeeded) {
              emit(const PaymentInstructionsState.success());
              return _killTimer();
            } else if (status == PaymentStatus.canceled) {
              emit(const PaymentInstructionsState.orderCanceled());
              return _killTimer();
            }
          },
        );

        _statusPollingAttempts++;
      },
    );
  }

  /// Останавливает таймер опроса статуса платежа.
  void _killTimer() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  @override
  Future<void> close() {
    _pollingTimer?.cancel();
    return super.close();
  }
}
