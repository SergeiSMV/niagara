import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/bloc/bonuses_bloc/bonuses_bloc.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/bonus_data/horizontal_bonus_cards_data_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/history/accrual_history_button.dart';

class BonusLevelStatusDataWidget extends StatelessWidget {
  const BonusLevelStatusDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final backImageWidth = context.screenWidth;
    final backImageHeight =
        (context.screenHeight / AppConst.kCommon4) + kToolbarHeight;
    return BlocBuilder<BonusesBloc, BonusesState>(
      builder: (_, state) => state.maybeWhen(
        orElse: SizedBox.shrink,
        loaded: (bonuses, _) => Stack(
          children: [
            bonuses.level.cardImage.image(
              width: backImageWidth,
              height: backImageHeight,
              fit: BoxFit.cover,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bonuses.level.toLocale(),
                  style: context.textStyle.headingTypo.h2
                      .withColor(context.colors.mainColors.white),
                ),
                AppConst.kCommon16.verticalBox,
                const HorizontalBonusCardsDataWidget(),
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
        ),
      ),
    );
  }
}
