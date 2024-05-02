import 'package:niagara_app/core/utils/enums/location_precision.dart';
import 'package:niagara_app/features/locations/addresses/domain/models/address.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart' hide Address;

extension GeoObjectToLocationExt on GeoObject {
  Address toLocation() {
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

    return Address(
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
      locationId: '',
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
