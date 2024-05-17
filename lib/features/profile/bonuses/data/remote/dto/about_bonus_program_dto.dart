import 'package:json_annotation/json_annotation.dart';
import 'package:niagara_app/core/core.dart';

part 'about_bonus_program_dto.g.dart';

@JsonSerializable(createToJson: false)
class AboutBonusProgramDto extends Equatable {
  const AboutBonusProgramDto({
    required this.privilege,
    required this.bonusMain,
    required this.bonusTemp,
  });

  @JsonKey(name: 'privilege')
  final List<PrivilegeDto> privilege;
  @JsonKey(name: 'bonus_main')
  final List<BonusDto> bonusMain;
  @JsonKey(name: 'bonus_temp')
  final List<BonusDto> bonusTemp;

  factory AboutBonusProgramDto.fromJson(Map<String, dynamic> json) =>
      _$AboutBonusProgramDtoFromJson(json);

  @override
  List<Object?> get props => [privilege, bonusMain, bonusTemp];
}

@JsonSerializable(createToJson: false)
class PrivilegeDto extends Equatable {
  const PrivilegeDto({
    required this.titleName,
    required this.titleText,
    required this.titlePict,
  });

  @JsonKey(name: 'title_name')
  final String titleName;
  @JsonKey(name: 'title_text')
  final String titleText;
  @JsonKey(name: 'title_pict')
  final String titlePict;

  factory PrivilegeDto.fromJson(Map<String, dynamic> json) =>
      _$PrivilegeDtoFromJson(json);

  @override
  List<Object?> get props => [titleName, titleText, titlePict];
}

@JsonSerializable(createToJson: false)
class BonusDto extends Equatable {
  const BonusDto({
    required this.titleText,
  });

  @JsonKey(name: 'title_text')
  final String titleText;

  factory BonusDto.fromJson(Map<String, dynamic> json) =>
      _$BonusDtoFromJson(json);

  @override
  List<Object?> get props => [titleText];
}
