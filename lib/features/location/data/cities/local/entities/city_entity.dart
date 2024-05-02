import 'package:equatable/equatable.dart';

/// Сущность города для работы с базой данных
class CityEntity extends Equatable {
  const CityEntity({
    required this.id,
    required this.province,
    required this.locality,
    required this.latitude,
    required this.longitude,
    required this.phone,
  });

  final int id;
  final String province;
  final String locality;
  final double latitude;
  final double longitude;
  final String phone;

  @override
  List<Object?> get props => [
        id,
        province,
        locality,
        latitude,
        longitude,
        phone,
      ];
}
