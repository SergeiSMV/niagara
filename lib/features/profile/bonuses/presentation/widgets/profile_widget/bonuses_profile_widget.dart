import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/bloc/bonuses_bloc/bonuses_bloc.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/home_widget/unauthorized_bonuses_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/profile_widget/basic_status_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/profile_widget/special_status_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/vip_status_widget.dart';

class BonusesProfileWidget extends StatelessWidget {
  const BonusesProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BonusesBloc, BonusesState>(
      builder: (_, state) => state.maybeWhen(
        loading: () => Center(
          child: Padding(
            padding: AppInsets.kVertical32 + AppInsets.kVertical2,
            child: Assets.lottie.loadCircle.lottie(
              width: AppSizes.kGeneral64,
              height: AppSizes.kGeneral64,
              repeat: true,
            ),
          ),
        ),
        loaded: (bonuses, description) {
          if (bonuses.level.isBasicStatus) {
            return BasicStatusWidget(bonuses: bonuses);
          } else if (bonuses.level.isSpecialStatus) {
            return SpecialStatusWidget(bonuses: bonuses);
          } else if (bonuses.level.isVIPStatus) {
            return Stack(
              children: [
                bonuses.level.cardImage.image(),
                VipStatusWidget(bonuses: bonuses, description: description),
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        },
        unauthorized: () => Stack(
          children: [
            Assets.images.unauthProfile.image(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: AppInsets.kHorizontal16 + AppInsets.kVertical48,
                  child: Assets.images.logo.svg(),
                ),
                const UnauthorizedBonusesWidget(),
              ],
            ),
          ],
        ),
        orElse: SizedBox.shrink,
      ),
    );
  }
}
