import 'package:niagara_app/core/utils/enums/location_precision.dart';
import 'package:niagara_app/features/location/domain/entities/location.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart';

extension GeoObjectToLocationExt on GeoObject {
  Location toLocation() {
    final lat = point?.latitude ?? 0;
    final lon = point?.longitude ?? 0;

    final name = this.name ?? '';
    final description = this.description ?? '';

    final precision = LocationPrecision.fromString(
      metaDataProperty?.geocoderMetaData?.precision,
    );

    final country = _addressComponent(KindResponse.country);
    final province = _addressComponent(KindResponse.province);
    final area = _addressComponent(KindResponse.area);
    final locality = _addressComponent(KindResponse.locality);
    final district = _addressComponent(KindResponse.district);
    final street = _addressComponent(KindResponse.street);
    final house = _addressComponent(KindResponse.house);

    return Location(
      coordinates: (lat, lon),
      name: name,
      description: description,
      precision: precision,
      address: LocationAddress(
        country: country,
        province: province,
        area: area,
        locality: locality,
        district: district,
        street: street,
        house: house,
      ),
    );
  }

  String _addressComponent(KindResponse kind) {
    final components = metaDataProperty?.geocoderMetaData?.address?.components;
    final name = components
        ?.firstWhere(
          (e) => e.kind == kind,
          orElse: () => Component(kind: kind, name: ''),
        )
        .name;
    return name ?? '';
  }
}
