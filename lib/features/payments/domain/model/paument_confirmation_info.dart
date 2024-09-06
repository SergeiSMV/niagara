import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/payment_statuses.dart';

class PaymentConfirmationInfo extends Equatable {
  const PaymentConfirmationInfo({
    required this.confirmationUrl,
    required this.status,
    required this.success,
  });

  /// Индикатор, требуется ли подтверждение платежа.
  bool get confirmationRequired => status == PaymentStatus.pending;

  /// Ссылка на форму для подтверждения платежа.
  final String? confirmationUrl;

  /// Статус платежа.
  final PaymentStatus status;

  // TODO: Не очень понятен смысл этого флажка. Он `false`, когда платёж не
  // прошёл или когда нужно подтверждение?
  /// Успешно ли был создан платеж.
  final bool success;

  @override
  List<Object?> get props => [confirmationUrl, status, success];
}
