import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/splash/presentation/cubit/splash_cubit.dart';

/// Виджет загрузчика внизу экрана
class BottomLoaderWidget extends StatelessWidget {
  const BottomLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: AppConst.kCommon8,
      child: BlocBuilder<SplashCubit, SplashState>(
        builder: (context, state) => state.maybeWhen(
          readyToMain: () => const _SpinnerLoader(),
          orElse: () => const SizedBox.shrink(),
        ),
      ),
    );
  }
}

class _SpinnerLoader extends StatelessWidget {
  const _SpinnerLoader();

  @override
  Widget build(BuildContext context) {
    return Assets.lottie.loadCircleWhite.lottie(
      repeat: true,
      width: AppConst.kLoaderSmall,
      height: AppConst.kLoaderSmall,
    );
  }
}
