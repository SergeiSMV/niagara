import 'package:niagara_app/features/locations/_common/domain/models/base_locality.dart';

/// Модель города (населенного пункта)
class City extends BaseLocality {
  const City({
    required super.id,
    required super.coordinates,
    required super.province,
    required super.locality,
    required this.phone,
    required this.searchSpan,
  });

  final String phone;

  /// Пара максимальных расстойний (разниц координат от центра), которые
  /// описывают эллипс зоны поиска города.
  final ({double diffLat, double diffLong})? searchSpan;

  @override
  String get name => super.locality;

  @override
  List<Object?> get props => [
        super.id,
        super.coordinates,
        super.province,
        super.locality,
        phone,
      ];
}
