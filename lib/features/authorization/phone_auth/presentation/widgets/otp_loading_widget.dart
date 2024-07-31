import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/authorization/phone_auth/presentation/bloc/auth_bloc/auth_bloc.dart';

class OtpLoadingWidget extends StatelessWidget {
  const OtpLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return AnimatedSwitcher(
          transitionBuilder: (child, animation) =>
              ScaleTransition(scale: animation, child: child),
          duration: const Duration(milliseconds: 500),
          child: state.maybeWhen(
            orElse: () => const SizedBox.shrink(),
            loading: () => Assets.lottie.waterCircleLoading.lottie(
              height: AppSizes.kLoaderBig,
              width: AppSizes.kLoaderBig,
            ),
          ),
        );
      },
    );
  }
}
