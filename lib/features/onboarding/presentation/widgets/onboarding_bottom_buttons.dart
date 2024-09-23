import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/enums/onboarding_step.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/onboarding/presentation/bloc/onboarding_cubit.dart';

class OnboardingBottomButtonsWidget extends StatelessWidget {
  const OnboardingBottomButtonsWidget({
    required this.step,
  });

  final OnboardingStep step;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.mainColors.white,
        boxShadow: [
          BoxShadow(
            color: context.colors.textColors.main
                .withOpacity(AppSizes.kShadowOpacity),
            blurRadius: AppSizes.kGeneral12,
            offset: AppConstants.kShadowTop,
          ),
        ],
      ),
      child: Padding(
        padding: AppInsets.kVertical12 +
            AppInsets.kHorizontal16 +
            AppInsets.kBottom12,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTextButton.primary(
              onTap: cubit.showNextWithAction,
              text: t.onboarding.next,
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 500),
              child: step.skippable
                  ? AppTextButton.invisible(
                      onTap: cubit.showNext,
                      text: t.onboarding.later,
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
