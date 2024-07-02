// ignore_for_file: sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:niagara_app/core/common/data/remote/dto/product_dto.dart';

part 'profile_dto.g.dart';

@JsonSerializable()
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
    this.bonusesLevelNext,
    this.bonusesDateEnd,
    this.revThisMonth,
    this.bottlesCount,
    this.bottles,
    this.locationDefault,
  });

  @JsonKey(name: 'ID')
  final String? id;

  @JsonKey(name: 'NAME')
  final String? name;

  @JsonKey(name: 'LAST_NAME')
  final String? lastName;

  @JsonKey(name: 'SECOND_NAME')
  final String? secondName;

  @JsonKey(name: 'LOGIN')
  final String? login;

  @JsonKey(name: 'EMAIL')
  final String? email;

  @JsonKey(name: 'CITY')
  final String? city;

  @JsonKey(includeToJson: false, name: 'BIRTHDAY')
  final String? birthday;

  @JsonKey(includeToJson: false, name: 'BONUSES_CARD_NUMBER')
  final String? bonusesCardNumber;

  @JsonKey(includeToJson: false, name: 'BONUSES_COUNT')
  final String? bonusesCount;

  @JsonKey(includeToJson: false, name: 'BONUSES_TEMP_COUNT')
  final String? bonusesTempCount;

  @JsonKey(includeToJson: false, name: 'BONUSES_TEMP_LAST_DATE')
  final String? bonusesTempLastDate;

  @JsonKey(includeToJson: false, name: 'BONUSES_TEMP_DAYS')
  final String? bonusesTempDays;

  @JsonKey(includeToJson: false, name: 'BONUSES_LEVEL')
  final String? bonusesLevel;

  @JsonKey(includeToJson: false, name: 'BONUSES_LEVEL_NEXT')
  final String? bonusesLevelNext;

  @JsonKey(includeToJson: false, name: 'BONUSES_DATE_END')
  final DateTime? bonusesDateEnd;

  @JsonKey(includeToJson: false, name: 'REV_THIS_MONTH')
  final int? revThisMonth;

  @JsonKey(includeToJson: false, name: 'BOTTELS_COUNT')
  final int? bottlesCount;

  @JsonKey(includeToJson: false, name: 'BOTTELS')
  final List<ProductDto>? bottles;

  @JsonKey(includeToJson: false, name: 'LOCATION_DEFAULT')
  final String? locationDefault;

  factory ProfileDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDtoToJson(this);

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
      ];
}