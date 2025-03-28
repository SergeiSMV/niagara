import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/constants/app_borders.dart';
import '../../../../core/utils/constants/app_insets.dart';
import '../../../../core/utils/constants/app_sizes.dart';
import '../../../../core/utils/gen/assets.gen.dart';

/// Виджет для отображения изображения промо.
class PromotionImageWidget extends StatelessWidget {
  const PromotionImageWidget({
    required this.imageUrl,
    super.key,
  });

  /// URL изображения промо.
  final String imageUrl;

  @override
  Widget build(BuildContext context) => Padding(
        padding: AppInsets.kAll16,
        child: ClipRRect(
          borderRadius: AppBorders.kCircular16,
          child: ExtendedImage.network(
            imageUrl,
            fit: BoxFit.fill,
            loadStateChanged: (state) {
              switch (state.extendedImageLoadState) {
                case LoadState.loading:
                  return Assets.lottie.loadCircle.lottie(
                    width: AppSizes.kGeneral64,
                    height: AppSizes.kGeneral64,
                    repeat: true,
                  );
                case LoadState.completed:
                  return state.completedWidget;
                case LoadState.failed:
                  return const Center(
                    child: Icon(Icons.error_outline),
                  );
              }
            },
          ),
        ),
      );
}
