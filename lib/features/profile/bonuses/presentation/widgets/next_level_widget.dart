import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/bloc/bonuses_bloc/bonuses_bloc.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/bonus_next_level_amount_slider.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/next_level_status_widget.dart';

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
              NextLevelStatusWidget(
                nextLevel: bonuses.nextLevel,
                toNextLevel: statusDescription.maxSum,
              ),
              AppConst.kCommon16.verticalBox,
              BonusNextLevelAmountSlider(
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
