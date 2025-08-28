import 'package:yandex_geocoder/yandex_geocoder.dart' hide Address;

import '../../../../../core/utils/enums/location_precision.dart';
import '../../domain/models/address.dart';

extension GeoObjectToLocationExt on GeoObject {
  Address toLocation() {
    final id = '${this.name} $description'.hashCode;

    final lat = point?.latitude ?? 0;
    final lon = point?.longitude ?? 0;

    final name = this.name ?? '';

    final precision = LocationPrecision.fromString(
      metaDataProperty?.geocoderMetaData?.precision,
    );

    // Берем область (второе поле KindResponse.province)
    // вместо федерального округа
    final province = _getSecondProvince(); // "... область"
    final locality = _addressComponent(KindResponse.locality);
    final district = _addressComponent(KindResponse.area); // район из area
    final street = _addressComponent(KindResponse.street);
    final house = _addressComponent(KindResponse.house);

    return Address(
      id: id,
      coordinates: (lat, lon),
      name: name,
      description: '',
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

  String _getSecondProvince() {
    // Второе поле KindResponse.province - область
    final components =
        metaDataProperty?.geocoderMetaData?.address?.components ?? [];
    final provinces =
        components.where((c) => c.kind == KindResponse.province).toList();
    return provinces.length >= 2 ? provinces[1].name ?? '' : '';
  }
}
