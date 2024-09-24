import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';

/// Виджет для отображения квадратного закрулённого блока-превью сториз.
class StoryPreviewWidget extends StatelessWidget {
  const StoryPreviewWidget({
    super.key,
    this.imageUrl,
    required this.title,
    required this.seen,
  });

  /// Ссылка на превью-изображение.
  final String? imageUrl;

  /// Заголовок сториз.
  final String title;

  /// Индикатор просмотра сториз.
  final bool seen;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSizes.kGeneral94,
      height: AppSizes.kGeneral94,
      child: Stack(
        children: [
          // Изображение с линейным градиентом на фоне.
          Container(
            padding: AppInsets.kAll2,
            decoration: BoxDecoration(
              border: Border.all(
                width: AppSizes.kGeneral2,
                color: seen
                    ? context.colors.fieldBordersColors.focus
                    : context.colors.mainColors.accent,
              ),
              borderRadius: AppBorders.kCircular14,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: AppBorders.kCircular12,
                gradient: LinearGradient(
                  colors: context.colors.gradientColors.storyPreview,
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: SizedBox.expand(
                child: imageUrl?.isNotEmpty ?? false
                    ? ClipRRect(
                        borderRadius: AppBorders.kCircular12,
                        child: ExtendedImage.network(
                          imageUrl!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ),
          // Заголовок истории.
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Text(
              title,
              style: context.textStyle.textTypo.tx4Medium
                  .withColor(context.colors.textColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
