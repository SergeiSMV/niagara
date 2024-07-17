import 'package:equatable/equatable.dart';
import 'package:niagara_app/features/stories/domain/model/slide.dart';

class Story extends Equatable {
  const Story({
    required this.id,
    required this.title,
    required this.slides,
    required this.image,
    required this.open,
  });

  final String id;
  final String title;
  final String image;
  final bool open;
  final List<Slide> slides;

  @override
  List<Object?> get props => [
        id,
        title,
        slides,
        open,
        image,
      ];
}
