// ignore_for_file: sort_constructors_first

import 'package:niagara_app/core/core.dart';

/// Сущность магазина для работы с базой данных
class ShopEntity extends Equatable {
  const ShopEntity({
    required this.id,
    required this.province,
    required this.locality,
    required this.latitude,
    required this.longitude,
    required this.storeDays,
    required this.openTime,
    required this.closeTime,
    required this.schedule,
  });

  final int id;
  final String province;
  final String locality;
  final double latitude;
  final double longitude;
  final int storeDays;
  final String openTime;
  final String closeTime;
  final List<ShopScheduleEntity> schedule;

  @override
  List<Object?> get props => [
        id,
        province,
        locality,
        latitude,
        longitude,
        storeDays,
        openTime,
        closeTime,
        schedule,
      ];
}


class ShopScheduleEntity extends Equatable {
  const ShopScheduleEntity({
    required this.day,
    required this.openTime,
    required this.closeTime,
  });

  final int day;
  final String openTime;
  final String closeTime;

  factory ShopScheduleEntity.fromJson(Map<String, dynamic> json) {
    return ShopScheduleEntity(
      day: json['day'] as int,
      openTime: json['openTime'] as String,
      closeTime: json['closeTime'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'openTime': openTime,
      'closeTime': closeTime,
    };
  }

  @override
  List<Object?> get props => [
        day,
        openTime,
        openTime,
      ];
}
