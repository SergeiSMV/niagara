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
    required this.workTime,
  });

  final int id;
  final String province;
  final String locality;
  final double latitude;
  final double longitude;
  final List<ShopWorkTimeEntity> workTime;

  @override
  List<Object?> get props => [
        id,
        province,
        locality,
        latitude,
        longitude,
        workTime,
      ];
}

class ShopWorkTimeEntity extends Equatable {
  const ShopWorkTimeEntity({
    required this.day,
    required this.timeStart,
    required this.timeEnd,
  });

  final int day;
  final String timeStart;
  final String timeEnd;

  factory ShopWorkTimeEntity.fromJson(Map<String, dynamic> json) {
    return ShopWorkTimeEntity(
      day: json['day'] as int,
      timeStart: json['timeStart'] as String,
      timeEnd: json['timeEnd'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'timeStart': timeStart,
      'timeEnd': timeEnd,
    };
  }

  @override
  List<Object?> get props => [
        day,
        timeStart,
        timeEnd,
      ];
}
