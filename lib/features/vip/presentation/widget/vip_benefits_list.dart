import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/status_description.dart';

/// Блок с преимуществами подписки.
class VipBenefitsList extends StatelessWidget {
  const VipBenefitsList(this.benefits);

  final List<BenefitDescription> benefits;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          t.vip.benefitsTitle,
          style: context.textStyle.headingTypo.h2,
        ),
        AppBoxes.kHeight24,
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: AppBorders.kCircular12,
            color: context.colors.mainColors.bgCard,
          ),
          child: ListView.separated(
            padding: AppInsets.kHorizontal12 + AppInsets.kVertical4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              final BenefitDescription benefit = benefits[index];
              return _BenefitTileWidget(
                title: benefit.title,
                description: benefit.description,
              );
            },
            separatorBuilder: (_, __) =>
                Divider(color: context.colors.otherColors.separator30),
            itemCount: benefits.length,
          ),
        ),
      ],
    );
  }
}

/// Плитка с пунктом преимущества.
class _BenefitTileWidget extends StatelessWidget {
  const _BenefitTileWidget({required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kVertical12,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: AppInsets.kTop6,
            child: Assets.images.star.image(
              width: AppSizes.kGeneral32,
              height: AppSizes.kGeneral32,
            ),
          ),
          AppBoxes.kWidth12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: context.textStyle.textTypo.tx1SemiBold,
                  overflow: TextOverflow.clip,
                ),
                AppBoxes.kHeight8,
                Text(
                  description,
                  style: context.textStyle.textTypo.tx2Medium.withColor(
                    context.colors.textColors.secondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
