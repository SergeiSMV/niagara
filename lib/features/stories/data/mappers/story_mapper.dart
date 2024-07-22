import 'package:niagara_app/features/stories/data/mappers/slide_mapper.dart';
import 'package:niagara_app/features/stories/data/remote/dto/story_dto.dart';
import 'package:niagara_app/features/stories/domain/model/story.dart';

extension StoryDtoMapper on StoryDto {
  Story toModel() => Story(
        id: id ?? '',
        title: title ?? '',
        image: image ?? '',
        open: open ?? false,
        slides: slides?.map((e) => e.toModel()).toList() ?? [],
      );
}
