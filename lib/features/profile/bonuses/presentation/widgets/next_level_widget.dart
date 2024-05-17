import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/enums/status_level_type.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/string_extension.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/bloc/bonuses_bloc/bonuses_bloc.dart';

class NextLevelWidget extends StatelessWidget {
  const NextLevelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppConst.kCommon12.horizontal + AppConst.kCommon16.vertical,
      decoration: BoxDecoration(
        color: context.colors.mainColors.white,
        borderRadius: BorderRadius.circular(AppConst.kCommon12),
        boxShadow: [
          BoxShadow(
            color: context.colors.textColors.accent
                .withOpacity(AppConst.kCommon01 + AppConst.kCommon005),
            blurRadius: AppConst.kCommon24,
            offset: const Offset(
              -AppConst.kCommon2,
              AppConst.kCommon6,
            ),
          ),
        ],
      ),
      child: BlocBuilder<BonusesBloc, BonusesState>(
        builder: (_, state) => state.maybeWhen(
          orElse: SizedBox.shrink,
          loaded: (bonuses, statusDescription) => Column(
            children: [
              _NextLevelStatusWidget(
                nextLevel: bonuses.nextLevel,
                toNextLevel: statusDescription.maxSum,
              ),
              AppConst.kCommon16.verticalBox,
              _BonusNextLevelAmountSlider(
                currentAmount: bonuses.revThisMonth,
                maxAmount: statusDescription.maxSum,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BonusNextLevelAmountSlider extends StatelessWidget {
  const _BonusNextLevelAmountSlider({
    required this.currentAmount,
    required this.maxAmount,
  });

  final int currentAmount;
  final int maxAmount;

  @override
  Widget build(BuildContext context) {
    final activeColor = context.colors.mainColors.accent;
    final inactiveColor = context.colors.mainColors.light;

    final percent = currentAmount / maxAmount;
    final lastPointColor = percent == 1 ? activeColor : inactiveColor;
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            LinearProgressIndicator(
              value: currentAmount / maxAmount,
              color: activeColor,
              backgroundColor: inactiveColor,
              borderRadius: BorderRadius.circular(AppConst.kCommon8),
              minHeight: AppConst.kCommon4,
            ).paddingAll(AppConst.kCommon4),
            Positioned(
              left: 0,
              height: AppConst.kCommon8,
              width: AppConst.kCommon8,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: activeColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              right: 0,
              height: AppConst.kCommon8,
              width: AppConst.kCommon8,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: lastPointColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
        AppConst.kCommon4.verticalBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              t.bonuses.yourSpent(amount: currentAmount).spaceSeparateNumbers(),
              style: context.textStyle.descriptionTypo.des3.withColor(
                context.colors.textColors.secondary,
              ),
            ),
            Text(
              '$maxAmount ${t.common.rub}'.spaceSeparateNumbers(),
              style: context.textStyle.descriptionTypo.des3.withColor(
                context.colors.textColors.secondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _NextLevelStatusWidget extends StatelessWidget {
  const _NextLevelStatusWidget({
    required this.nextLevel,
    required this.toNextLevel,
  });

  final StatusLevel nextLevel;
  final int toNextLevel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: AppConst.kCommon2.toInt(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nextLevel.toLocale(),
                style: context.textStyle.textTypo.tx1SemiBold.withColor(
                  context.colors.textColors.main,
                ),
              ),
              AppConst.kCommon4.verticalBox,
              Text(
                t.bonuses
                    .toNextStatus(amount: toNextLevel)
                    .spaceSeparateNumbers(),
                style: context.textStyle.textTypo.tx2Medium.withColor(
                  context.colors.textColors.secondary,
                ),
              ),
            ],
          ),
        ),
        AppConst.kCommon16.horizontalBox,
        Flexible(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppConst.kCommon6),
            child: Stack(
              children: [
                nextLevel.cardImage.image(),
                Assets.images.logo
                    .svg(height: AppConst.kCommon8)
                    .paddingAll(AppConst.kCommon6),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
