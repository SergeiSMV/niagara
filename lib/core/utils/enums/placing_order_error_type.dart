import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Ошибки при оформлении заказа.
enum OrderPlacingErrorType {
  /// Не указаны данные получателя.
  noRecipientData,

  /// Не указаны дата и время доставки, если они требуются.
  noDeliveryDate,

  /// Не указан тип оплаты.
  noPaymentMethod,

  /// Нет интернета.
  noInternet,

  /// Неподдерживаемый способ оплаты.
  unsupportedPaymentMethod,

  /// Неизвестная ошибка.
  unknown;

  /// Преобразует тип ошибки оформления заказа в текст ошибки.
  String get toErrorTitle => switch (this) {
        noRecipientData => t.errors.noRecipientData.title,
        noDeliveryDate => t.errors.noDeliveryTime.title,
        noPaymentMethod => t.errors.noPaymentMethod.title,
        noInternet => t.errors.noInternet.title,
        unsupportedPaymentMethod => t.errors.unsupportedPaymentMethod.title,
        unknown => t.errors.unknownError.title,
      };

  /// Преобразует тип ошибки оформления заказа в опциональное описание ошибки.
  String? get toErrorDescription => switch (this) {
        OrderPlacingErrorType.noInternet => t.errors.noInternet.description,
        _ => null,
      };
}
