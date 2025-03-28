// ignore_for_file: sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:niagara_app/core/common/data/remote/dto/product_dto.dart';

class ProfileDto extends Equatable {
  const ProfileDto({
    this.id,
    this.name,
    this.lastName,
    this.secondName,
    this.login,
    this.email,
    this.city,
    this.birthday,
    this.bonusesCardNumber,
    this.bonusesCount,
    this.bonusesTempCount,
    this.bonusesTempLastDate,
    this.bonusesTempDays,
    this.bonusesLevel,
    this.bonusesLevelEnd,
    this.bonusesLevelNext,
    this.bonusesDateEnd,
    this.revThisMonth,
    this.bottlesCount,
    this.bottles,
    this.bottlesGroupId,
    this.locationDefault,
    this.yearlyBonusDate,
    this.yearlyBonusCount,
    this.ordersCount,
  });

  final String? id;
  final String? name;
  final String? lastName;
  final String? secondName;
  final String? login;
  final String? email;
  final String? city;
  final String? birthday;
  final String? bonusesCardNumber;
  final String? bonusesCount;
  final String? bonusesTempCount;
  final String? bonusesTempLastDate;
  final String? bonusesTempDays;
  final String? bonusesLevel;
  final String? bonusesLevelEnd;
  final String? bonusesLevelNext;
  final DateTime? bonusesDateEnd;
  final int? revThisMonth;
  final int? bottlesCount;
  final List<ProductDto>? bottles;
  final String? bottlesGroupId;
  final String? locationDefault;
  final DateTime? yearlyBonusDate;
  final int? yearlyBonusCount;
  final int? ordersCount;

  factory ProfileDto.fromJson(Map<String, dynamic> json) => ProfileDto(
        id: json['ID'] as String?,
        name: json['NAME'] as String?,
        lastName: json['LAST_NAME'] as String?,
        secondName: json['SECOND_NAME'] as String?,
        login: json['PHONE'] as String?,
        email: json['EMAIL'] as String?,
        city: json['CITY'] as String?,
        birthday: json['BIRTHDAY'] as String?,
        bonusesCardNumber: json['BONUSES_CARD_NUMBER'] as String?,
        bonusesCount: json['BONUSES_COUNT'] as String?,
        bonusesTempCount: json['BONUSES_TEMP_COUNT'] as String?,
        bonusesTempLastDate: json['BONUSES_DATE_END'] as String?,
        bonusesTempDays: json['BONUSES_TEMP_DAYS'] as String?,
        bonusesLevel: json['BONUSES_LEVEL'] as String?,
        bonusesLevelEnd: json['BONUSES_LEVEL_END'] as String?,
        bonusesLevelNext: json['BONUSES_LEVEL_NEXT'] as String?,
        yearlyBonusCount: json['BONUSES_FOR_YEAR_SUM'] as int?,
        yearlyBonusDate: json['BONUSES_FOR_YEAR_DATE'] == null
            ? null
            : DateTime.tryParse(json['BONUSES_FOR_YEAR_DATE'] as String),
        bonusesDateEnd: json['BONUSES_DATE_END'] == null
            ? null
            : DateTime.tryParse(json['BONUSES_DATE_END'] as String),
        revThisMonth: (json['REV_THIS_MONTH'] as num?)?.toInt(),
        bottlesCount: (json['BOTTELS_COUNT'] as num?)?.toInt(),
        bottles: (json['BOTTELS'] as List<dynamic>?)
            ?.map((e) => ProductDto.fromJson(e as Map<String, dynamic>))
            .toList(),
        bottlesGroupId: json['BOTTELS_GROUP'] as String?,
        locationDefault: json['LOCATION_DEFAULT'] as String?,
        ordersCount: (json['ORDERS_COUNT'] as num?)?.toInt(),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'ID': id,
        'NAME': name,
        'LAST_NAME': lastName,
        'SECOND_NAME': secondName,
        'LOGIN': login,
        'EMAIL': email,
        'CITY': city,
        'BIRTHDAY': birthday,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        lastName,
        secondName,
        login,
        email,
        city,
        birthday,
        bonusesCardNumber,
        bonusesCount,
        bonusesTempCount,
        bonusesTempLastDate,
        bonusesTempDays,
        bonusesLevel,
        bonusesLevelNext,
        bonusesDateEnd,
        revThisMonth,
        bottlesCount,
        bottles,
        locationDefault,
        ordersCount,
      ];
}
