import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Виджет, отображающий закругленный баннер с фоновым градиентом, текстовым
/// содержимым и изображением справа.
class BannerWidget extends StatelessWidget {
  const BannerWidget({
    super.key,
    required this.onTap,
    required this.gradient,
    required this.title,
    required this.description,
    required this.image,
    required this.rightPositioning,
    required this.bottomPositioning,
  });

  /// Коллбек для навигации по нажатию на баннер.
  final VoidCallback onTap;

  /// Градиент для фона баннера.
  final LinearGradient gradient;

  /// Заголовок баннера.
  final String title;

  /// Текст под заголовком.
  final String description;

  /// Изображение в правом углу баннера.
  final AssetGenImage image;

  /// Позиционирование изображения в баннере.
  final double rightPositioning;

  /// Позиционирование изображения в баннере.
  final double bottomPositioning;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: AppBorders.kCircular12,
        ),
        child: Stack(
          clipBehavior: Clip.antiAlias,
          children: [
            /// Изображение в правом углу баннера.
            Positioned(
              top: 0,
              right: rightPositioning,
              bottom: bottomPositioning,
              child: image.image(
                fit: BoxFit.cover,
              ),
            ),

            // Текстовое содержимое баннера.
            Padding(
              padding: AppInsets.kAll12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.textStyle.textTypo.tx2SemiBold.withColor(
                      context.colors.textColors.white,
                    ),
                  ),
                  AppBoxes.kHeight4,
                  Text(
                    description,
                    style: context.textStyle.textTypo.tx3Medium.withColor(
                      context.colors.textColors.white,
                    ),
                  ),
                  AppBoxes.kHeight12,
                  Row(
                    children: [
                      Text(
                        t.profile.banners.more,
                        style:
                            context.textStyle.buttonTypo.btn3semiBold.withColor(
                          context.colors.textColors.white,
                        ),
                      ),
                      Assets.icons.arrowRight.svg(
                        width: AppSizes.kIconSmall,
                        height: AppSizes.kIconSmall,
                        colorFilter: ColorFilter.mode(
                          context.colors.mainColors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
