import 'package:flutter/material.dart';
import '../../../../../core/common/presentation/widgets/app_network_image_widget.dart';
import '../../../../../core/common/presentation/widgets/buttons/app_text_button.dart';
import '../../../../../core/utils/constants/app_borders.dart';
import '../../../../../core/utils/constants/app_boxes.dart';
import '../../../../../core/utils/constants/app_constants.dart';
import '../../../../../core/utils/constants/app_insets.dart';
import '../../../../../core/utils/enums/slide_enums.dart';
import '../../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../../core/utils/extensions/text_style_ext.dart';
import '../../../domain/model/slide.dart';

/// Виджет, отображающий слайд истории.
class StorySlideWidget extends StatelessWidget {
  const StorySlideWidget({required this.slide, super.key});

  /// Слайд.
  final Slide slide;

  @override
  Widget build(BuildContext context) {
    /// Цвета текста.
    final textColors = context.colors.textColors;

    /// Флаг для определения, является ли фон слайда темным.
    final isBgDark = slide.themeImage == SlideTheme.dark;

    /// Флаг для определения, является ли текст слайда темным.
    final isTextDark = slide.themeText == SlideTheme.dark;

    /// Цвет тега слайда.
    final labelColor = slide.labelColor != null
        ? Color(int.parse(slide.labelColor!))
        : context.colors.infoColors.green;

    return Stack(
      fit: StackFit.expand,
      children: [
        // Базовая заливка фона с градиентом.
        StoryBackGroundWidget(isDark: isBgDark, align: slide.align),

        // Фоновое изображение.
        if (slide.backgroundImage != null)
          AppNetworkImageWidget(
            url: slide.backgroundImage!,
            whiteLoader: isBgDark,
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
    required this.isDark,
    required this.align,
    super.key,
  });

  final bool isDark;
  final SlideAlign align;

  @override
  Widget build(BuildContext context) {
    final gradientColors = context.colors.gradientColors;
    return ColoredBox(
      color: context.colors.mainColors.accent,
      child: isDark
          ? StoryBackGroundGradient.dark(
              align,
              gradientColors.bgStoryDark1,
              gradientColors.bgStoryDark2,
            )
          : StoryBackGroundGradient.ligth(
              align,
              gradientColors.bgStoryLight1,
              gradientColors.bgStoryLight2,
            ),
    );
  }
}

/// Конструирует градиенты для фона слайда.
abstract class StoryBackGroundGradient {
  static DecoratedBox dark(
    SlideAlign align,
    List<Color> colors1,
    List<Color> colors2,
  ) {
    return _construct(align, true, colors1, colors2);
  }

  static DecoratedBox ligth(
    SlideAlign align,
    List<Color> colors1,
    List<Color> colors2,
  ) {
    return _construct(align, false, colors1, colors2);
  }

  static DecoratedBox _construct(
    SlideAlign align,
    bool isDark,
    List<Color> colors1,
    List<Color> colors2,
  ) {
    switch (align) {
      case SlideAlign.center:
        return const DecoratedBox(
          decoration: BoxDecoration(
            // TODO: Получить из контекста и прокинуть сюда.
            color: Color(0x4B000000),
          ),
        );

      case SlideAlign.top:
      case SlideAlign.bottom:
        final isTop = align == SlideAlign.top;

        return DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: isTop ? Alignment.topCenter : Alignment.bottomCenter,
              end: isTop ? Alignment.bottomCenter : Alignment.topCenter,
              colors: colors1,
              stops: isDark
                  ? AppConstants.darkSlideGradientStops1
                  : AppConstants.lightSlideGradientStops1,
            ),
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: isTop ? Alignment.topCenter : Alignment.bottomCenter,
                end: isTop ? Alignment.bottomCenter : Alignment.topCenter,
                colors: colors2,
                stops: isDark
                    ? AppConstants.darkSlideGradientStops2
                    : AppConstants.lightSlideGradientStops2,
              ),
            ),
          ),
        );
    }
  }
}

/// Виджет для короткого тега слайда, отображающийся над заголовком.
class StorySlideTag extends StatelessWidget {
  const StorySlideTag({required this.title, required this.color, super.key});

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
