import 'package:niagara_app/core/core.dart';

/// Данные о реферальном коде.
class ReferralCodeData extends Equatable {
  /// Реферальный код.
  final String code;

  /// Сообщение, отправляемое получателю пригласительного кода.
  final String message;

  // ignore: sort_constructors_first
  const ReferralCodeData({
    required this.code,
    required this.message,
  });

  @override
  List<Object?> get props => [code, message];
}
