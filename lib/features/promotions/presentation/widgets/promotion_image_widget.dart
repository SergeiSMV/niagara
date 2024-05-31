import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';

class PromotionImageWidget extends StatelessWidget {
  const PromotionImageWidget({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kAll16,
      child: ClipRRect(
        borderRadius: AppBorders.kCircular16,
        child: ExtendedImage.network(
          imageUrl,
          fit: BoxFit.fill,
          loadStateChanged: (state) =>
              state.extendedImageLoadState == LoadState.loading
                  ? Assets.lottie.loadCircle.lottie(
                      width: AppSizes.kGeneral64,
                      height: AppSizes.kGeneral64,
                      repeat: true,
                    )
                  : null,
        ),
      ),
    );
  }
}
