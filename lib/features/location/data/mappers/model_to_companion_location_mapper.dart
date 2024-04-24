import 'package:drift/drift.dart';
import 'package:niagara_app/core/utils/database/app_database.dart';
import 'package:niagara_app/features/location/data/models/location_model.dart';

extension ModelToCompanionLocationMapper on LocationModel {
  LocationsCompanion toCompanion() {
    return LocationsCompanion(
      latitude: Value(latitude),
      longitude: Value(longitude),
      province: Value(province),
      city: Value(city),
      locality: Value(locality),
      district: Value(district),
      street: Value(street),
      house: Value(house),
      floor: Value(floor),
      flat: Value(flat),
      entrance: Value(entrance),
      name: Value(name),
      description: Value(description),
      deliveryId: Value(deliveryId),
      serviceLastDate: Value(serviceLastDate),
      serviceNextDate: Value(serviceNextDate),
      isActive: Value(isActive ?? true),
      precision: Value(precision),
      isPrimary: Value(isPrimary),
    );
  }
}
