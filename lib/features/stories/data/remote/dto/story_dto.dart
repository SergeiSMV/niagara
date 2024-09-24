// ignore_for_file: sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:niagara_app/features/stories/data/remote/dto/slide_dto.dart';

part 'story_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.screamingSnake, createToJson: false)
class StoryDto extends Equatable {
  final String? id;
  final String? title;
  final String? image;
  final bool? open;
  final List<SlideDto>? slides;

  const StoryDto({
    this.id,
    this.title,
    this.image,
    this.open,
    this.slides,
  });

  factory StoryDto.fromJson(Map<String, dynamic> json) =>
      _$StoryDtoFromJson(json);

  @override
  List<Object?> get props => [
        id,
        title,
        image,
        open,
        slides,
      ];
}
