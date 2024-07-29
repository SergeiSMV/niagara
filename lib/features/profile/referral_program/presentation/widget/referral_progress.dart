import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Виджет с прогрессбаром и описанием прогресса.
class ProgressWidget extends StatelessWidget {
  const ProgressWidget({
    super.key,
    required this.reward,
    required this.goal,
    required this.count,
  });

  final int reward;
  final int goal;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          t.referral.progressTitle(n: goal),
          style: context.textStyle.headingTypo.h3,
        ),
        AppBoxes.kHeight16,
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: AppBorders.kCircular12,
            color: context.colors.mainColors.white,
            boxShadow: [
              BoxShadow(
                color: context.colors.textColors.main
                    .withOpacity(AppSizes.kShadowOpacity0_12),
                blurRadius: AppSizes.kGeneral24,
                offset: AppConstants.kShadowDiagonal,
              ),
            ],
          ),
          child: Padding(
            padding: AppInsets.kHorizontal12 + AppInsets.kVertical16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Assets.images.gift.image(
                      width: AppSizes.kImageMediumWidth,
                      height: AppSizes.kImageMediumHeight,
                    ),
                    AppBoxes.kWidth12,
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            t.referral.progressDescription(
                              bonuses: reward,
                              n: goal,
                            ),
                            style: context.textStyle.textTypo.tx1SemiBold,
                          ),
                          AppBoxes.kHeight4,
                          Text(
                            t.referral.progressRemaining(n: goal - count),
                            style:
                                context.textStyle.textTypo.tx2Medium.withColor(
                              context.colors.textColors.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                AppBoxes.kHeight24,
                _ProgressBar(count: count, total: goal),
                AppBoxes.kHeight8,
                Text(
                  t.referral.progressInvited(n: count),
                  style: context.textStyle.descriptionTypo.des3.withColor(
                    context.colors.textColors.secondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.count, required this.total});

  final int count;
  final int total;

  Widget _getElement(int index) {
    final bool filled = index < count;

    if (index == 0) {
      return _ProgressBarElement.left(filled: filled);
    } else if (index == total - 1) {
      return _ProgressBarElement.right(filled: filled);
    } else {
      return _ProgressBarElement(filled: filled);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(total, _getElement),
    );
  }
}

class _ProgressBarElement extends StatelessWidget {
  const _ProgressBarElement({required this.filled})
      : roundedLeft = false,
        roundedRight = false;

  const _ProgressBarElement.left({required this.filled})
      : roundedLeft = true,
        roundedRight = false;

  const _ProgressBarElement.right({required this.filled})
      : roundedLeft = false,
        roundedRight = true;

  final bool filled;
  final bool roundedLeft;
  final bool roundedRight;

  @override
  Widget build(BuildContext context) {
    const Radius radius = Radius.circular(8);

    return Expanded(
      child: Padding(
        padding: AppInsets.kRight4,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: filled
                ? context.colors.mainColors.accent
                : context.colors.mainColors.light,
            borderRadius: BorderRadius.horizontal(
              left: roundedLeft ? radius : Radius.zero,
              right: roundedRight ? radius : Radius.zero,
            ),
          ),
          child: const SizedBox(
            height: AppSizes.kGeneral5,
          ),
        ),
      ),
    );
  }
}
