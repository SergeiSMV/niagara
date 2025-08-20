import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/constants/app_insets.dart';
import '../../../../../../core/utils/constants/app_sizes.dart';
import '../../../../../../core/utils/gen/assets.gen.dart';
import '../../bloc/bonuses_bloc/bonuses_bloc.dart';
import '../vip_status_widget.dart';
import 'basic_status_widget.dart';
import 'special_status_widget.dart';
import 'unauthorized_bonuses_widget.dart';

/// Виджет для отображения бонусов на главной странице
class HomeBonusesWidget extends StatelessWidget {
  const HomeBonusesWidget({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<BonusesBloc, BonusesState>(
        builder: (_, state) => state.maybeWhen(
          loading: () => Padding(
            padding: AppInsets.kVertical32 + AppInsets.kVertical2,
            child: Assets.lottie.loadCircle.lottie(
              width: AppSizes.kGeneral64,
              height: AppSizes.kGeneral64,
              repeat: true,
            ),
          ),
          loaded: (bonuses, description) {
            final status = bonuses.level;
            if (status.isBasicStatus) {
              return Padding(
                padding: AppInsets.kHorizontal16 + AppInsets.kVertical24,
                child: BasicStatusWidget(bonuses: bonuses),
              );
            } else if (status.isSpecialStatus) {
              return Padding(
                padding: AppInsets.kHorizontal16 + AppInsets.kVertical24,
                child: SpecialStatusWidget(bonuses: bonuses),
              );
            } else if (status.isVIPStatus) {
              return Padding(
                padding: AppInsets.kBottom24,
                child: VipStatusWidget(
                  bonuses: bonuses,
                  description: description,
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
          unauthorized: UnauthorizedBonusesWidget.new,
          orElse: SizedBox.shrink,
        ),
      );
}
