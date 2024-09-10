import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/payment_statuses.dart';
import 'package:niagara_app/features/payments/data/remote/dto/payment_confirmation_dto.dart';

/// Предоставляет ссылку на форму для подтверждения платежа и его статус с
/// сервера.
abstract interface class IPaymentsRemoteDataSource {
  /// Отправляет запрос на создание платежа на сервере. Принимает номер заказа
  /// [orderId] и платёжный токен от эквайринг-сервиса [paymentToken].
  ///
  /// Возвращает [PaymentConfirmationDto], содержащий текущий cтатус платежа и
  /// ссылку на форму для подтверждения платежа, если таковая требуется.
  Future<Either<Failure, PaymentConfirmationDto>> getConfirmationUrl({
    required String orderId,
    required String paymentToken,
  });

  /// Отправляет запрос на получение статуса платежа по номеру заказа [orderId].
  Future<Either<Failure, PaymentStatus>> getPaymentStatus({
    required String orderId,
  });
}

@LazySingleton(as: IPaymentsRemoteDataSource)
class PaymentsRemoteDataSource implements IPaymentsRemoteDataSource {
  PaymentsRemoteDataSource(this._requestHandler);

  final RequestHandler _requestHandler;

  @override
  Future<Either<Failure, PaymentConfirmationDto>> getConfirmationUrl({
    required String orderId,
    required String paymentToken,
  }) =>
      _requestHandler.sendRequest<PaymentConfirmationDto, Map<String, dynamic>>(
        request: (dio) => dio.post(
          ApiConst.kGetConfirmationUrl,
          data: {
            'ORDER_ID': orderId,
            'PAYMENT_TOKEN': paymentToken,
            'RETURN_URL': ApiConst.kReturnUrl,
          },
        ),
        converter: PaymentConfirmationDto.fromJson,
        failure: PaymentsRemoteDataFailure.new,
      );

  @override
  Future<Either<Failure, PaymentStatus>> getPaymentStatus({
    required String orderId,
  }) =>
      _requestHandler.sendRequest<PaymentStatus, Map<String, dynamic>>(
        request: (dio) => dio.get(
          ApiConst.kGetPaymentStatus,
          queryParameters: {
            'order_id': orderId,
          },
        ),
        converter: (json) => PaymentStatus.fromString(json['status'] as String),
        failure: PaymentsRemoteDataFailure.new,
      );
}
