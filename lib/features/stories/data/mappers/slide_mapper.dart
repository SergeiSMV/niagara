import 'package:niagara_app/features/stories/data/remote/dto/slide_dto.dart';
import 'package:niagara_app/features/stories/domain/model/slide.dart';

extension SlideDtoMapper on SlideDto {
  Slide toModel() => Slide(
        id: id ?? '',
        title: title.nonEmpty,
        description: description.nonEmpty,
        // По умолчанию выравнивание текста по верхнему краю.
        align: align.nonEmpty != null
            ? SlideAlign.values.firstWhere(
                (s) => s.toString() == 'SlideAlign.${align!.toLowerCase()}')
            : SlideAlign.top,
        backgroundImage: backgroundImage.nonEmpty,
        // Тема слайда по умолчанию - темная.
        themeImage: themeImage.nonEmpty != null
            ? SlideTheme.values.firstWhere((s) =>
                s.toString() == 'SlideTheme.${themeImage!.toLowerCase()}')
            : SlideTheme.dark,
        // Тема текста по умолчанию - светлая (для контраста с темой слайда).
        themeText: themeText.nonEmpty != null
            ? SlideTheme.values.firstWhere(
                (s) => s.toString() == 'SlideTheme.${themeText!.toLowerCase()}')
            : SlideTheme.ligth,
        labelTitle: labelTitle.nonEmpty,
        labelColor: labelColor.nonEmpty,
        buttonVisible: buttonVisible ?? false,
        buttonText: buttonText.nonEmpty,
        buttonImage: buttonImage.nonEmpty,
        buttonColor: buttonColor.nonEmpty,
        buttonLink: buttonLink.nonEmpty,
        buttonLinkType: buttonLinkType.nonEmpty != null
            ? LinkType.values.firstWhere((s) =>
                s.toString() == 'LinkType.${buttonLinkType!.toLowerCase()}')
            : LinkType.product,
        productGroup: productGroup.nonEmpty,
        note: note.nonEmpty,
      );
}

extension _NullIfEmpty on String? {
  /// Возвращает содержание строки, если она не равна `null` и не пустая и
  /// `null` в противном случае.
  String? get nonEmpty => this?.isEmpty ?? true ? null : this;
}
