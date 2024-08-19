import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/payment_statuses.dart';
import 'package:niagara_app/features/payments/domain/model/paument_confirmation_info.dart';
import 'package:yookassa_payments_flutter/models/payment_method_types.dart';

/// Репозиторий для работы с платежами через эквайринг-сервис (ЮКасса).
///
/// Производит токенизацию (ввод платёжных данных), подтверждение оплаты (ввод
/// данных для подтверждения, например кода из СМС) и получение статуса платежа.
abstract interface class IPaymentsRepository {
  /// Запускает процес токенизации.
  ///
  /// Открывает модальное окно с формой оплаты, в которой пользователь вводит
  /// данные для оплаты.
  ///
  /// Возвращает:
  /// - [paymentToken], необходимый серверу для создания платежа;
  /// - [null], если пользователь закрыл форму без подтверждения;
  /// - [Failure], если произошла ошибка.
  ///
  /// Принимает:
  /// - [clientApplicationKey] - секретный ключ приложения в эквайринг-сервисе.
  /// - [shopId] - идентификатор магазина эквайринг-сервисе.
  /// - [paymentMethod] - метод оплаты.
  /// - [amountRub] - сумма платежа в рублях.
  /// - [title] - заголовок платежа.
  /// - [subtitle] - описание платежа.
  Future<Either<Failure, String?>> startTokenization({
    required String clientApplicationKey,
    required String shopId,
    required PaymentMethod paymentMethod,
    required String amountRub,
    required String title,
    required String subtitle,
    String? customerId,
  });

  /// Запрашивает ссылку на окно с подтверждением платежа для выбранного метода
  /// оплаты по соответствующим этому платежу [orderId] и [paymentToken].
  Future<Either<Failure, PaymentConfirmationInfo>> getConfirmationUrl({
    required String orderId,
    required String paymentToken,
  });

  /// Открывает модальное окно с формой подтверждения платежа.
  ///
  /// Ничего не возвращает, для получения статуса платежа необходимо
  /// использовать метод `getPaymentStatus`.
  ///
  /// - [confirmationUrl] - URL, открывающийся в модальном окне.
  /// - [clientApplicationKey] - секретный ключ приложения в эквайринг-сервисе.
  /// - [shopId] - идентификатор магазина эквайринг-сервисе.
  /// - [paymentMethod] - метод оплаты.
  Future<Either<Failure, void>> startConfirmation({
    required String confirmationUrl,
    required String clientApplicationKey,
    required String shopId,
    required PaymentMethod paymentMethod,
  });

  /// Возвращает статус платежа по [orderId], ассоциированному с этим платежом.
  ///
  /// **Важно**: результат выполнения метода может меняться со временем. Для
  /// для получения актуальной информации нужно периодически вызывать этот
  /// метод, пока не вернётся значение, отличное от [PaymentStatus.pending] или
  /// не пройдёт время ожидания.
  Future<Either<Failure, PaymentStatus>> getPaymentStatus({
    required String orderId,
  });
}
