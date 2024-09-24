import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Статус чистки оборудования
enum CleaningStatuses {
  /// Нет статуса
  no,

  /// Требуется чистка
  cleaningIsRequired,

  /// Ожидается чистка
  cleaningIsExpected;

  String toLocale() => switch (this) {
        no => '',
        cleaningIsRequired => t.equipments.cleaningStatuses.cleaningIsRequired,
        cleaningIsExpected => t.equipments.cleaningStatuses.cleaningIsExpected,
      };

  static CleaningStatuses toEnum(String value) {
    if (value.isEmpty) return CleaningStatuses.no;
    if (value == t.equipments.cleaningStatuses.cleaningIsRequired) {
      return CleaningStatuses.cleaningIsRequired;
    }
    if (value == t.equipments.cleaningStatuses.cleaningIsExpected) {
      return CleaningStatuses.cleaningIsExpected;
    }
    return CleaningStatuses.no;
  }
}
