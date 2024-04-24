import 'package:niagara_app/core/utils/database/app_database.dart';
import 'package:niagara_app/features/location/data/models/location_model.dart';

extension TableToModelLocationMapper on LocationTable {
  LocationModel toModel() => LocationModel(
        latitude: latitude,
        longitude: longitude,
        province: province,
        city: city,
        locality: locality,
        district: district,
        street: street,
        house: house,
        floor: floor,
        flat: flat,
        entrance: entrance,
        name: name,
        description: description,
        precision: precision,
        deliveryId: deliveryId,
        serviceLastDate: serviceLastDate,
        serviceNextDate: serviceNextDate,
        isActive: isActive,
        isPrimary: isPrimary,
      );
}
