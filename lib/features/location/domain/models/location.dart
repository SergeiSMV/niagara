import 'package:niagara_app/core/utils/enums/location_precision.dart';
import 'package:niagara_app/core/utils/extensions/iterable_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/location/domain/models/base_locality.dart';

/// Модель местоположения для доставки
class Location extends BaseLocality {
  const Location({
    required super.id,
    required super.coordinates,
    required super.province,
    required super.locality,
    required this.precision,
    required this.district,
    required this.street,
    required this.house,
    required this.flat,
    required this.entrance,
    required this.floor,
    required this.locationId,
    required String name,
    required String description,
    this.isDefault = false,
  })  : _name = name,
        _description = description;

  final String district;
  final String street;
  final String house;
  final String flat;
  final String entrance;
  final String floor;
  final String _name;
  final String _description;
  final LocationPrecision precision;
  final bool isDefault;
  final String locationId;

  @override
  String get name => _streetHouse.isNotEmpty ? _streetHouse : _name;

  String get description => _description;

  String get additional =>
      [_flat, _entrance, _floor].whereNotNull().join(', ').toLowerCase();

  bool get hasDetails => additional.isNotEmpty;

  String get _streetHouse =>
      street.isNotEmpty && house.isNotEmpty ? '$street, $house' : '';

  String? get _flat =>
      flat.isNotEmpty ? '${t.locations.flatOffice_short} $flat' : null;

  String? get _entrance =>
      entrance.isNotEmpty ? '${t.locations.entrance} $entrance' : null;

  String? get _floor => floor.isNotEmpty ? '${t.locations.floor} $floor' : null;

  Location copyWithoutDetails({
    String? flat,
    String? entrance,
    String? floor,
    String? comment,
  }) =>
      Location(
        id: id,
        coordinates: coordinates,
        province: province,
        locality: locality,
        precision: precision,
        district: district,
        street: street,
        house: house,
        flat: flat ?? this.flat,
        entrance: entrance ?? this.entrance,
        floor: floor ?? this.floor,
        name: name,
        description: comment ?? description,
        isDefault: isDefault,
        locationId: locationId,
      );

  @override
  List<Object?> get props => [
        id,
        coordinates,
        province,
        locality,
        precision,
        district,
        street,
        house,
        flat,
        entrance,
        floor,
        _name,
        _description,
        isDefault,
        locationId,
      ];
}
