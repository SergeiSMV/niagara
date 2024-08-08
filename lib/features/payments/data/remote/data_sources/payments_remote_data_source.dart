import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/payment_statuses.dart';

/// Предоставляет ссылку на форму для подтверждения платежа и его статус с
/// сервера.
abstract interface class IPaymentsRemoteDataSource {
  /// Отправляет запрос на создание платежа на сервере. Принимает номер заказа
  /// [orderId] и платёжный токен от эквайринг-сервиса [paymentToken].
  ///
  /// Возвращает `confirmationUrl`, по которой будет находиться форма для
  /// подтверждения платежа.
  Future<Either<Failure, String>> getConfirmationUrl({
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
  Future<Either<Failure, String>> getConfirmationUrl({
    required String orderId,
    required String paymentToken,
  }) =>
      _requestHandler.sendRequest<String, Map<String, dynamic>>(
        request: (dio) => dio.post(
          ApiConst.kGetConfirmationUrl,
          data: {
            'order_id': orderId,
            'payment_token': paymentToken,
          },
        ),
        converter: (json) => json['confirmation_url'] as String,
        failure: PaymentsRemoteDataFailure.new,
      );

  @override
  Future<Either<Failure, PaymentStatus>> getPaymentStatus({
    required String orderId,
  }) =>
      _requestHandler.sendRequest<PaymentStatus, Map<String, dynamic>>(
        request: (dio) => dio.post(
          ApiConst.kGetPaymentStatus,
          data: {
            'order_id': orderId,
          },
        ),
        converter: (json) =>
            PaymentStatus.fromString(json['payment_status'] as String),
        failure: PaymentsRemoteDataFailure.new,
      );
}
