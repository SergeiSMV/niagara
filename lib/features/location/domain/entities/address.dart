import 'package:equatable/equatable.dart';

class Address extends Equatable {
  const Address({
    required this.name,
    required this.coordinates,
    required this.region,
    required this.district,
    required this.city,
    required this.location,
    required this.street,
    required this.build,
    this.id = '',
    this.floor,
    this.flatOfficeNumber,
    this.entrance,
    this.comment,
  });

  final String name;
  final (double latitude, double longitude) coordinates;
  final String region;
  final String district;
  final String city;
  final String location;
  final String street;
  final int build;
  final String id;
  final int? floor;
  final int? flatOfficeNumber;
  final int? entrance;
  final String? comment;

  @override
  List<Object?> get props => [
        id,
        name,
        coordinates,
        region,
        district,
        city,
        location,
        street,
        build,
        floor,
        flatOfficeNumber,
        entrance,
        comment,
      ];
}

extension AddressShort on Address {
  String get shortAddress => '$street, $build';
}
