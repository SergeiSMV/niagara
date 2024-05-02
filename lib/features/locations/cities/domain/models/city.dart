import 'package:niagara_app/features/locations/_common/domain/models/base_locality.dart';

/// Модель города (населенного пункта)
class City extends BaseLocality {
  const City({
    required super.id,
    required super.coordinates,
    required super.province,
    required super.locality,
    required this.phone,
  });

  final String phone;

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
