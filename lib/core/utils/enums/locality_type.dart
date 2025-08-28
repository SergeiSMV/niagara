/// Типы населенного пункта
///
/// [city] - город
/// [village] - село
/// [town] - посёлок
/// [hamlet] - деревня
enum LocalityType {
  /// Город
  city,

  /// Село
  village,

  /// Посёлок
  town,

  /// Деревня
  hamlet;
}

/// Расширение для определения типа населенного пункта
extension LocalityTypeExtension on String {
  LocalityType get localityType {
    final lower = toLowerCase();

    if (lower.contains('село') || lower.contains('с.')) {
      return LocalityType.village;
    }
    if (lower.contains('посёлок') ||
        lower.contains('пос.') ||
        lower.contains('поселок')) {
      return LocalityType.town;
    }
    if (lower.contains('деревня') || lower.contains('дер.')) {
      return LocalityType.hamlet;
    }

    return LocalityType.city;
  }
}
