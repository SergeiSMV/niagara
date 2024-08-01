// ignore_for_file: sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activation_option_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.screamingSnake, createToJson: false)
class ActivationOptionDto extends Equatable {
  final int count;
  final int sum;
  final int sumForMounth;
  final String title;
  final String description;
  final String descriptionFull;
  final String label;

  const ActivationOptionDto({
    required this.count,
    required this.sum,
    required this.sumForMounth,
    required this.title,
    required this.description,
    required this.descriptionFull,
    required this.label,
  });

  factory ActivationOptionDto.fromJson(Map<String, dynamic> json) =>
      _$ActivationOptionDtoFromJson(json);

  @override
  List<Object?> get props => [
        count,
        sum,
        sumForMounth,
        title,
        description,
        descriptionFull,
        label,
      ];
}
