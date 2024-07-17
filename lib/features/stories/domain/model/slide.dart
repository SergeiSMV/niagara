import 'package:equatable/equatable.dart';
import 'package:niagara_app/features/stories/data/remote/dto/slide_dto.dart';

class Slide extends Equatable {
  const Slide({
    required this.id,
    required this.title,
    required this.description,
    required this.align,
    required this.backgroundImage,
    required this.themeImage,
    required this.themeText,
    required this.labelTitle,
    required this.labelColor,
    required this.buttonVisible,
    required this.buttonText,
    required this.buttonImage,
    required this.buttonColor,
    required this.buttonLink,
    required this.buttonLinkType,
    required this.productGroup,
    required this.note,
  });

  final String id;
  final String title;
  final String description;
  final SlideAlign align;
  final String backgroundImage;
  final SlideTheme themeImage;
  final SlideTheme themeText;
  final String labelTitle;
  final String labelColor;
  final bool buttonVisible;
  final String buttonText;
  final String buttonImage;
  final String buttonColor;
  final String buttonLink;
  final LinkType buttonLinkType;
  final String productGroup;
  final String note;

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
