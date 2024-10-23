import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/enums/status_level_type.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/bonuses.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/status_description.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/bloc/bonuses_bloc/bonuses_bloc.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/bonus_next_level_amount_slider.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/next_level_status_widget.dart';

class NextLevelWidget extends StatelessWidget {
  const NextLevelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppInsets.kHorizontal12 + AppInsets.kVertical16,
      decoration: BoxDecoration(
        color: context.colors.mainColors.white,
        borderRadius: AppBorders.kCircular12,
        boxShadow: [
          BoxShadow(
            color: context.colors.textColors.accent.withOpacity(.15),
            blurRadius: AppSizes.kGeneral24,
            offset: const Offset(
              -AppSizes.kGeneral2,
              AppSizes.kGeneral6,
            ),
          ),
        ],
      ),
      child: BlocBuilder<BonusesBloc, BonusesState>(
        builder: (_, state) => state.maybeWhen(
          orElse: SizedBox.shrink,
          loaded: _NextLevelData.new,
        ),
      ),
    );
  }
}

class _NextLevelData extends StatelessWidget {
  const _NextLevelData(this.bonuses, this.statusDescription);

  final Bonuses bonuses;
  final StatusDescription statusDescription;

  @override
  Widget build(BuildContext context) {
    final bool isMaxLevel = bonuses.level == StatusLevel.platinum;

    return Column(
      children: [
        NextLevelStatusWidget(
          nextLevel: isMaxLevel ? bonuses.level : bonuses.nextLevel,
          toNextLevel: statusDescription.maxSum,
          toKeepAmount: statusDescription.minSum,
          isMax: isMaxLevel,
        ),
        AppBoxes.kHeight16,
        BonusNextLevelAmountSlider(
          currentAmount: bonuses.revThisMonth,
          maxAmount:
              isMaxLevel ? statusDescription.minSum : statusDescription.maxSum,
        ),
      ],
    );
  }
}
