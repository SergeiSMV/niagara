// ignore_for_file: sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.screamingSnake)
class ProfileDto extends Equatable {
  const ProfileDto({
    required this.id,
    required this.name,
    required this.lastName,
    required this.secondName,
    required this.login,
    required this.email,
    required this.city,
    required this.birthday,
    required this.bonusesCardNumber,
    required this.bonusesCount,
    required this.bonusesTempCount,
    required this.bonusesTempLastDate,
    required this.bonusesTempDays,
    required this.bonusesLevel,
    required this.bonusesLevelNext,
    required this.bonusesDateEnd,
    required this.revThisMonth,
    required this.bonuses,
    required this.locationDefault,
  });

  final String id;
  final String name;
  final String lastName;
  final String secondName;
  final String login;
  final String email;
  final String city;
  @JsonKey(includeToJson: false)
  final String birthday;
  @JsonKey(includeToJson: false)
  final String bonusesCardNumber;
  @JsonKey(fromJson: int.parse, includeToJson: false)
  final int bonusesCount;
  @JsonKey(fromJson: int.parse, includeToJson: false)
  final int bonusesTempCount;
  @JsonKey(includeToJson: false)
  final String bonusesTempLastDate;
  @JsonKey(fromJson: int.parse, includeToJson: false)
  final int bonusesTempDays;
  @JsonKey(includeToJson: false)
  final String bonusesLevel;
  @JsonKey(includeToJson: false)
  final String bonusesLevelNext;
  @JsonKey(includeToJson: false)
  final DateTime bonusesDateEnd;
  @JsonKey(includeToJson: false)
  final int revThisMonth;
  @JsonKey(includeToJson: false)
  final List<BonusDto> bonuses;
  @JsonKey(includeToJson: false)
  final String locationDefault;

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
        bonuses,
        locationDefault,
      ];
}

@JsonSerializable(fieldRename: FieldRename.screamingSnake)
class BonusDto extends Equatable {
  const BonusDto({
    required this.bonusProgramId,
    required this.bonusTemp,
    required this.bonusDateEnd,
    required this.bonusCount,
  });

  final String bonusProgramId;
  final bool bonusTemp;
  final DateTime bonusDateEnd;
  final int bonusCount;

  factory BonusDto.fromJson(Map<String, dynamic> json) =>
      _$BonusDtoFromJson(json);
  Map<String, dynamic> toJson() => _$BonusDtoToJson(this);

  @override
  List<Object?> get props => [
        bonusProgramId,
        bonusTemp,
        bonusDateEnd,
        bonusCount,
      ];
}
