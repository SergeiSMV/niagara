import 'package:niagara_app/features/stories/data/remote/dto/slide_dto.dart';
import 'package:niagara_app/features/stories/domain/model/slide.dart';

extension SlideDtoMapper on SlideDto {
  Slide toModel() => Slide(
        id: id ?? '',
        title: title ?? '',
        description: description ?? '',
        align: (align?.isNotEmpty ?? false)
            ? SlideAlign.values.firstWhere(
                (s) => s.toString() == 'SlideAlign.${align!.toLowerCase()}')
            : SlideAlign.top,
        backgroundImage: backgroundImage ?? '',
        themeImage: (themeImage?.isNotEmpty ?? false)
            ? SlideTheme.values.firstWhere((s) =>
                s.toString() == 'SlideTheme.${themeImage!.toLowerCase()}')
            : SlideTheme.dark,
        themeText: (themeText?.isNotEmpty ?? false)
            ? SlideTheme.values.firstWhere(
                (s) => s.toString() == 'SlideTheme.${themeText!.toLowerCase()}')
            : SlideTheme.dark,
        labelTitle: labelTitle ?? '',
        labelColor: labelColor ?? '',
        buttonVisible: buttonVisible ?? false,
        buttonText: buttonText ?? '',
        buttonImage: buttonImage ?? '',
        buttonColor: buttonColor ?? '',
        buttonLink: buttonLink ?? '',
        buttonLinkType: (buttonLinkType?.isNotEmpty ?? false)
            ? LinkType.values.firstWhere((s) =>
                s.toString() == 'LinkType.${buttonLinkType!.toLowerCase()}')
            : LinkType.offer,
        productGroup: productGroup ?? '',
        note: note ?? '',
      );
}
