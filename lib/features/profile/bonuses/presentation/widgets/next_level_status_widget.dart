import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/enums/status_level_type.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/string_extension.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class NextLevelStatusWidget extends StatelessWidget {
  const NextLevelStatusWidget({
    required this.currentLevel,
    required this.toNextLevel,
    required this.toKeepAmount,
    required this.isMax,
    super.key,
  });

  final StatusLevel currentLevel;
  final int toKeepAmount;
  final int toNextLevel;
  final bool isMax;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: AppSizes.kGeneral2.toInt(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${currentLevel.toLocale} ${t.bonuses.status.toLowerCase()}',
                style: context.textStyle.textTypo.tx1SemiBold.withColor(
                  context.colors.textColors.main,
                ),
              ),
              AppBoxes.kHeight4,
              Text(
                isMax
                    ? t.bonuses
                        .toKeepLevel(amount: toKeepAmount)
                        .spaceSeparateNumbers()
                    : t.bonuses
                        .toNextStatus(amount: toNextLevel)
                        .spaceSeparateNumbers(),
                style: context.textStyle.textTypo.tx2Medium.withColor(
                  context.colors.textColors.secondary,
                ),
              ),
            ],
          ),
        ),
        AppBoxes.kWidth16,
        Flexible(
          child: ClipRRect(
            borderRadius: AppBorders.kCircular6,
            child: Stack(
              children: [
                _nextLevelCard,
                Padding(
                  padding: AppInsets.kAll6,
                  child: Assets.images.logo.svg(height: AppSizes.kGeneral8),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Получает картинку следующего уровня.
  /// текущий статус - [currentLevel]
  Image get _nextLevelCard {
    switch (currentLevel) {
      case StatusLevel.silver:
        return Assets.images.bonusStatus.gold.image();
      case StatusLevel.gold:
        return Assets.images.bonusStatus.platinum.image();
      case StatusLevel.platinum:
        return Assets.images.bonusStatus.statusVIP.image();
      case StatusLevel.vip:
        return Assets.images.bonusStatus.statusVIP.image();
      case StatusLevel.partner:
        return Assets.images.bonusStatus.partner.image();
      case StatusLevel.employee:
        return Assets.images.bonusStatus.employer.image();
      case StatusLevel.social:
        return Assets.images.bonusStatus.social.image();
    }
  }


}
