import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';

class AppCenterLoader extends StatelessWidget {
  const AppCenterLoader({super.key});

  @override
  Widget build(BuildContext context) => Center(
        heightFactor: AppSizes.kGeneral4,
        child: Assets.lottie.loadCircle.lottie(
          width: AppSizes.kLoaderBig,
          height: AppSizes.kLoaderBig,
        ),
      );
}
