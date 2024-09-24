import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';

class LocationLoaderWidget extends StatelessWidget {
  const LocationLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: AppSizes.kGeneral4,
      child: Assets.lottie.loadCircle.lottie(
        repeat: true,
        width: AppSizes.kLoaderBig,
        height: AppSizes.kLoaderBig,
      ),
    );
  }
}
