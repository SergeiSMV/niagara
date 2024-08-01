import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Виджет с описанием бонусов для приглащающего и приглашенного.
class RewardsWidget extends StatelessWidget {
  const RewardsWidget({required this.rewardMe, required this.rewardFriend});

  final int rewardMe;
  final int rewardFriend;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: _RewardTile(
          title: t.referral.forYou,
          reward: rewardMe.toString(),
        ),
      ),
      AppBoxes.kWidth8,
      Expanded(
        child: _RewardTile(
          title: t.referral.forFriend,
          reward: rewardFriend.toString(),
        ),
      ),
    ]);
  }
}

class _RewardTile extends StatelessWidget {
  const _RewardTile({required this.title, required this.reward});

  final String title;
  final String reward;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: AppBorders.kCircular12,
        color: context.colors.mainColors.bgCard,
      ),
      child: Padding(
        padding: AppInsets.kAll8,
        child: Column(
          children: [
            Text(
              title,
              style: context.textStyle.textTypo.tx4Medium.withColor(
                context.colors.textColors.secondary,
              ),
            ),
            AppBoxes.kHeight8,
            Row(
              children: [
                Assets.icons.coinNiagara.svg(
                  width: AppSizes.kIconMedium,
                  height: AppSizes.kIconMedium,
                ),
                AppBoxes.kWidth6,
                Text(
                  '$reward ${t.referral.bonuses}',
                  style: context.textStyle.textTypo.tx2SemiBold,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
