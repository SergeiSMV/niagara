import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/theme/colors/text_colors.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/features/stories/domain/model/slide.dart';

/// Виджет, отображающий слайд истории.
class StorySlideWidget extends StatelessWidget {
  const StorySlideWidget({super.key, required this.slide});

  final Slide slide;

  @override
  Widget build(BuildContext context) {
    final TextColors textColors = context.colors.textColors;
    final bool isBgDark = slide.themeImage == SlideTheme.dark;
    final bool isTextDark = slide.themeText == SlideTheme.dark;
    final Color labelColor = slide.labelColor != null
        ? Color(int.parse(slide.labelColor!))
        : context.colors.infoColors.green;

    return Stack(
      fit: StackFit.expand,
      children: [
        // Базовая заливка фона с градиентом.
        StoryBackGroundWidget(isDark: isBgDark, align: slide.align),

        // Фоновое изображение.
        if (slide.backgroundImage != null)
          ExtendedImage.network(
            slide.backgroundImage!,
            fit: BoxFit.cover,
            printError: false,
          ),

        Padding(
          padding: AppInsets.kHorizontal24,
          child: Column(
            children: [
              AppBoxes.kHeight96,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: switch (slide.align) {
                    SlideAlign.top => MainAxisAlignment.start,
                    SlideAlign.center => MainAxisAlignment.center,
                    SlideAlign.bottom => MainAxisAlignment.end,
                  },
                  children: [
                    // Тег слайда.
                    if (slide.labelTitle != null) ...[
                      StorySlideTag(
                        title: slide.labelTitle!,
                        color: labelColor,
                      ),
                      AppBoxes.kHeight12,
                    ],

                    // Заголовок слайда.
                    if (slide.title != null) ...[
                      Text(
                        slide.title!,
                        style: context.textStyle.headingTypo.h1.withColor(
                          isTextDark ? textColors.main : textColors.white,
                        ),
                      ),
                      AppBoxes.kHeight12,
                    ],

                    // Slide description.
                    if (slide.description != null) ...[
                      Text(
                        slide.description!,
                        style: context.textStyle.textTypo.tx1Medium.withColor(
                          isTextDark ? textColors.main : textColors.white,
                        ),
                      ),
                      AppBoxes.kHeight64,
                    ],
                  ],
                ),
              ),

              // Кнопка слайда с описанием.
              if (slide.buttonVisible)
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // TODO: Добавить вариативность по цветам кнопки, если
                    // изменится дизайн. В дизайне пока что только два варианта
                    // (invisible / accent), можно и bool вместо цвета присылать
                    AppTextButton.invisible(
                      onTap: () {},
                      text: slide.buttonText,
                    ),

                    if (slide.note != null) ...[
                      AppBoxes.kHeight8,
                      Text(
                        slide.note!,
                        textAlign: TextAlign.center,
                        style: context.textStyle.textTypo.tx2Medium.withColor(
                          isTextDark ? textColors.main : textColors.white,
                        ),
                      ),
                    ],
                    AppBoxes.kHeight48,
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Виджет, отображающий фон слайда с учетом [align] и [isDark].
///
/// Градиент зависит от [align]. В случае позиционирования по центру градиент
/// отсутствует.
class StoryBackGroundWidget extends StatelessWidget {
  const StoryBackGroundWidget({
    super.key,
    required this.isDark,
    required this.align,
  });

  final bool isDark;
  final SlideAlign align;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.mainColors.accent,
      child: isDark
          ? StoryBackGroundGradient.dark(align)
          : StoryBackGroundGradient.ligth(align),
    );
  }
}

/// Конструирует градиенты для фона слайда.
abstract class StoryBackGroundGradient {
  static DecoratedBox dark(SlideAlign align) {
    return _construct(align, true);
  }

  static DecoratedBox ligth(SlideAlign align) {
    return _construct(align, false);
  }

  static DecoratedBox _construct(SlideAlign align, bool isDark) {
    switch (align) {
      case SlideAlign.center:
        return const DecoratedBox(
          decoration: BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, 0.3),
          ),
        );

      case SlideAlign.top:
      case SlideAlign.bottom:
        final bool isTop = align == SlideAlign.top;

        return DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: isTop ? Alignment.topCenter : Alignment.bottomCenter,
              end: isTop ? Alignment.bottomCenter : Alignment.topCenter,
              colors: isDark ? _colorsDark1 : _colorsLight1,
              stops: isDark ? _stopsDark1 : _stopsLight1,
            ),
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: isTop ? Alignment.topCenter : Alignment.bottomCenter,
                end: isTop ? Alignment.bottomCenter : Alignment.topCenter,
                colors: isDark ? _colorsDark2 : _colorsLigth2,
                stops: isDark ? _stopsDark2 : _stopsLigth2,
              ),
            ),
          ),
        );
    }
  }

  static const _stopsDark1 = [
    0.0,
    0.578025,
    0.578125,
    1.0,
  ];

  static const _stopsDark2 = [
    0.0,
    0.497046,
    0.769,
    1.0,
  ];

  static const _colorsDark1 = [
    Color.fromRGBO(0, 0, 0, 0.96),
    Color.fromRGBO(0, 0, 0, 0.3),
    Color.fromRGBO(0, 0, 0, 0.29),
    Color.fromRGBO(0, 0, 0, 0.06),
  ];

  static const _colorsDark2 = [
    Color.fromRGBO(0, 0, 0, 0.38),
    Color.fromRGBO(0, 0, 0, 0.29),
    Color.fromRGBO(0, 0, 0, 0.1),
    Color.fromRGBO(0, 0, 0, 0.05),
  ];

  static const _stopsLight1 = [
    0.0,
    0.497,
    0.8434,
    1.0,
  ];

  static const _stopsLigth2 = [
    0.0,
    0.5781,
    1.0,
  ];

  static const _colorsLight1 = [
    Color.fromRGBO(255, 255, 255, 0.384),
    Color.fromRGBO(255, 255, 255, 0.288),
    Color.fromRGBO(255, 255, 255, 0.048),
    Colors.transparent,
  ];

  static const _colorsLigth2 = [
    Color.fromRGBO(255, 255, 255, 0.96),
    Color.fromRGBO(255, 255, 255, 0.288),
    Colors.transparent,
  ];
}

/// Виджет для короткого тега слайда, отображающийся над заголовком.
class StorySlideTag extends StatelessWidget {
  const StorySlideTag({super.key, required this.title, required this.color});

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: AppBorders.kCircular8,
      ),
      child: Padding(
        padding:
            AppInsets.kHorizontal12 + AppInsets.kTop1 * 3 + AppInsets.kBottom4,
        child: Text(
          title,
          style: context.textStyle.buttonTypo.btn2semiBold.withColor(
            context.colors.textColors.white,
          ),
        ),
      ),
    );
  }
}
