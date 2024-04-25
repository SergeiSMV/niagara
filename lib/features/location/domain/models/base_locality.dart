import 'package:equatable/equatable.dart';

abstract class BaseLocality extends Equatable {
  const BaseLocality({
    required this.id,
    required this.coordinates,
    required this.province,
    required this.locality,
  });

  final int id;
  final (double latitude, double longitude) coordinates;
  final String province;
  final String locality;

  String get name;

  @override
  List<Object?> get props => [
        id,
        coordinates,
        province,
        locality,
      ];
}
