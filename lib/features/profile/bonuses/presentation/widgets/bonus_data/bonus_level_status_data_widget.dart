import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/bonuses.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/bonus_data/bonus_level_background_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/bonus_data/horizontal_bonus_cards_data_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/history/accrual_history_button.dart';

class BonusLevelStatusDataWidget extends StatelessWidget {
  const BonusLevelStatusDataWidget({
    required this.bonuses,
    super.key,
  });

  final Bonuses bonuses;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BonusLevelBackgroundWidget(level: bonuses.level),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              bonuses.level.toLocale(),
              style: context.textStyle.headingTypo.h2
                  .withColor(context.colors.mainColors.white),
            ),
            AppConst.kCommon16.verticalBox,
            HorizontalBonusCardsDataWidget(bonuses: bonuses),
            AppConst.kCommon16.verticalBox,
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AccrualHistoryButton(),
              ],
            ),
          ],
        ).paddingSymmetric(
          horizontal: AppConst.kCommon16,
          vertical: AppConst.kCommon32,
        ),
      ],
    );
  }
}
