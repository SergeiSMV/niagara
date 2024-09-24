enum LocationPrecision {
  /// Найден дом с указанным номером дома.
  exact,

  /// Найден дом с указанным номером, но с другим номером строения или корпуса.
  number,

  /// Найден дом с номером, близким к запрошенному.
  near,

  /// Найдены приблизительные координаты запрашиваемого дома.
  range,

  /// Найдена только улица.
  street,

  /// Не найдена улица, но найден, например, посёлок, район и т. п.
  other;

  bool get hasHouse =>
      this != LocationPrecision.street || this != LocationPrecision.other;

  static LocationPrecision fromString(String? value) =>
      LocationPrecision.values.firstWhere(
        (e) => e.toString().split('.').last == value,
        orElse: () => LocationPrecision.other,
      );

  static LocationPrecision parse({
    required String street,
    required String house,
  }) {
    if (house.isEmpty) return LocationPrecision.street;
    if (street.isEmpty) return LocationPrecision.other;
    return LocationPrecision.exact;
  }
}
