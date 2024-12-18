import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';

class AppCenterLoader extends StatelessWidget {
  const AppCenterLoader({
    super.key,
    this.isWhite = false,
    this.dense = false,
    this.size,
  });

  final double? size;

  /// [true] - белый лоадер, [false] - Main color (синий).
  final bool isWhite;

  final bool dense;

  LottieGenImage get _loader =>
      isWhite ? Assets.lottie.loadCircleWhite : Assets.lottie.loadCircle;

  @override
  Widget build(BuildContext context) => dense
      ? _loader.lottie(
          width: size ?? AppSizes.kLoaderBig,
          height: size ?? AppSizes.kLoaderBig,
        )
      : Center(
          heightFactor: AppSizes.kGeneral4,
          child: _loader.lottie(
            width: size ?? AppSizes.kLoaderBig,
            height: size ?? AppSizes.kLoaderBig,
          ),
        );
}
