// ignore_for_file: sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'slide_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.screamingSnake)
class SlideDto extends Equatable {
  final String? id;
  final String? title;
  final String? description;
  final String? align;
  final String? backgroundImage;
  final String? themeImage;
  final String? themeText;
  final String? labelTitle;
  final String? labelColor;
  final bool? buttonVisible;
  final String? buttonText;
  final String? buttonImage;
  final String? buttonColor;
  final String? buttonLink;
  final String? buttonLinkType;
  final String? productGroup;
  final String? note;

  const SlideDto({
    this.id,
    this.title,
    this.description,
    this.align,
    this.backgroundImage,
    this.themeImage,
    this.themeText,
    this.labelTitle,
    this.labelColor,
    this.buttonVisible,
    this.buttonText,
    this.buttonImage,
    this.buttonColor,
    this.buttonLink,
    this.buttonLinkType,
    this.productGroup,
    this.note,
  });

  factory SlideDto.fromJson(Map<String, dynamic> json) =>
      _$SlideDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SlideDtoToJson(this);

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        align,
        backgroundImage,
        themeImage,
        themeText,
        labelTitle,
        labelColor,
        buttonVisible,
        buttonText,
        buttonImage,
        buttonColor,
        buttonLink,
        buttonLinkType,
        productGroup,
        note,
      ];
}
