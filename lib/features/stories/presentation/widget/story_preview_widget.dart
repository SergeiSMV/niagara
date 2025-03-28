import 'package:flutter/material.dart';
import '../../../../core/common/presentation/widgets/app_network_image_widget.dart';
import '../../../../core/utils/constants/app_borders.dart';
import '../../../../core/utils/constants/app_insets.dart';
import '../../../../core/utils/constants/app_sizes.dart';
import '../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../core/utils/extensions/text_style_ext.dart';

/// Виджет для отображения квадратного закрулённого блока-превью сториз.
class StoryPreviewWidget extends StatelessWidget {
  const StoryPreviewWidget({
    required this.title,
    required this.seen,
    super.key,
    this.imageUrl,
  });

  /// Ссылка на превью-изображение.
  final String? imageUrl;

  /// Заголовок сториз.
  final String title;

  /// Индикатор просмотра сториз.
  final bool seen;

  @override
  Widget build(BuildContext context) => SizedBox(
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
                          child: AppNetworkImageWidget(
                            url: imageUrl!,
                            whiteLoader: true,
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
