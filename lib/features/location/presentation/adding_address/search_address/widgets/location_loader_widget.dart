import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';

class LocationLoaderWidget extends StatelessWidget {
  const LocationLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) => Center(
        heightFactor: AppConst.kCommon4,
        child: Assets.lottie.loadCircle.lottie(
          repeat: true,
          width: AppConst.kLoaderBig,
          height: AppConst.kLoaderBig,
        ),
      );
}
