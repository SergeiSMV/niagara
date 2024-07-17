import 'package:niagara_app/features/stories/data/remote/dto/slide_dto.dart';
import 'package:niagara_app/features/stories/domain/model/slide.dart';

extension SlideDtoMapper on SlideDto {
  Slide toModel() => Slide(
        id: id ?? '',
        title: title ?? '',
        description: description ?? '',
        align: align ?? SlideAlign.top,
        backgroundImage: backgroundImage ?? '',
        themeImage: themeImage ?? SlideTheme.dark,
        themeText: themeText ?? SlideTheme.dark,
        labelTitle: labelTitle ?? '',
        labelColor: labelColor ?? '',
        buttonVisible: buttonVisible ?? false,
        buttonText: buttonText ?? '',
        buttonImage: buttonImage ?? '',
        buttonColor: buttonColor ?? '',
        buttonLink: buttonLink ?? '',
        buttonLinkType: buttonLinkType ?? LinkType.offer,
        productGroup: productGroup ?? '',
        note: note ?? '',
      );
}
