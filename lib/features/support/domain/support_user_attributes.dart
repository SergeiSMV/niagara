import '../../../core/core.dart';

/// Набор атрибутов пользователя для чата службы поддержки.
class SupportUserAttributes extends Equatable {
  const SupportUserAttributes({
    required this.values,
  });

  /// Набор атрибутов пользователя.
  final Map<String, dynamic> values;

  /// Отформатированные атрибуты для подстановки в JS код, например:
  ///
  /// ```
  /// 'city': 'Белград кастом',
  /// 'last_order_id': '1234567890',
  /// 'app_version': '6.0.28+651',
  /// 'bonus_count': 1234,
  /// ```
  ///
  /// Данные могут быть только строковыми или числовыми.
  String get formatted => values.entries
      .map((e) {
        if (e.value is String) {
          return "${e.key}: '${e.value}'";
        } else if (e.value is int) {
          return '${e.key}: ${e.value}';
        }

        return null;
      })
      .nonNulls
      .join(', ');

  @override
  List<Object?> get props => [values];
}
