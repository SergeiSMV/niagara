import 'package:niagara_app/core/utils/enums/location_precision.dart';
import 'package:niagara_app/features/location/domain/models/location.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart';

extension GeoObjectToLocationExt on GeoObject {
  Location toLocation() {
    final id = '${this.name} ${this.description}'.hashCode;

    final lat = point?.latitude ?? 0;
    final lon = point?.longitude ?? 0;

    final name = this.name ?? '';
    final description = this.description ?? '';

    final precision = LocationPrecision.fromString(
      metaDataProperty?.geocoderMetaData?.precision,
    );

    final province = _addressComponent(KindResponse.province);
    final locality = _addressComponent(KindResponse.locality);
    final district = _addressComponent(KindResponse.district);
    final street = _addressComponent(KindResponse.street);
    final house = _addressComponent(KindResponse.house);

    return Location(
      id: id,
      coordinates: (lat, lon),
      name: name,
      description: description,
      precision: precision,
      province: province,
      locality: locality,
      district: district,
      street: street,
      house: house,
      flat: '',
      entrance: '',
      floor: '',
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
