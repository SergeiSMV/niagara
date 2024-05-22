import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
        borderRadius: BorderRadius.circular(AppSizes.kGeneral16),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: imageUrl,
          progressIndicatorBuilder: (_, __, ___) =>
              Assets.lottie.loadCircle.lottie(
            width: AppSizes.kGeneral64,
            height: AppSizes.kGeneral64,
            repeat: true,
          ),
        ),
      ),
    );
  }
}
