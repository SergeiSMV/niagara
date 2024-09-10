// ignore_for_file: sort_constructors_first

import 'package:json_annotation/json_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/bonuses/data/remote/dto/activation_option_dto.dart';

part 'status_description_dto.g.dart';

@JsonSerializable(createToJson: false)
class StatusDescriptionDto extends Equatable {
  const StatusDescriptionDto({
    required this.name,
    required this.title,
    required this.description,
    required this.minSum,
    required this.maxSum,
    required this.benefits,
    this.activationOptions,
  });

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'sum_min')
  final int minSum;

  @JsonKey(name: 'sum_max')
  final int maxSum;

  @JsonKey(name: 'list')
  final List<BenefitDto> benefits;

  // Поле `nullable`, потому что для бонусных программ его нет, а для
  // VIP-подписки есть.
  @JsonKey(name: 'activation_options')
  final List<ActivationOptionDto>? activationOptions;

  factory StatusDescriptionDto.fromJson(Map<String, dynamic> json) =>
      _$StatusDescriptionDtoFromJson(json);

  @override
  List<Object?> get props => [
        name,
        title,
        description,
        minSum,
        maxSum,
        benefits,
        activationOptions,
      ];
}

@JsonSerializable(createToJson: false)
class BenefitDto extends Equatable {
  const BenefitDto({
    required this.titleName,
    required this.titleText,
    required this.titlePict,
    required this.titleNameSmall,
    required this.titleTextSmall,
  });

  @JsonKey(name: 'title_name')
  final String titleName;

  @JsonKey(name: 'title_text')
  final String titleText;

  @JsonKey(name: 'title_pict')
  final String titlePict;

  @JsonKey(name: 'title_name_small')
  final String titleNameSmall;

  @JsonKey(name: 'title_text_small')
  final String titleTextSmall;

  factory BenefitDto.fromJson(Map<String, dynamic> json) =>
      _$BenefitDtoFromJson(json);

  @override
  List<Object?> get props => [titleName, titleText, titlePict];
}
