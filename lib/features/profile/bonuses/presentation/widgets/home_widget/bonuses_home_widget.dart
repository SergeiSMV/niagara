import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/bloc/bonuses_bloc/bonuses_bloc.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/bonus_data/bonuses_data_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/bonus_data/prepaid_water_data_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/home_widget/level_name_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/home_widget/qr_code_button.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/home_widget/unauthorized_bonuses_widget.dart';

class HomeBonusesWidget extends StatelessWidget {
  const HomeBonusesWidget({super.key});

  void _goToBonuses(BuildContext context) => context.navigateTo(
        const ProfileWrapper(
          children: [
            ProfileRoute(),
            MyBonusesRoute(),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kSymmetricH16 + AppInsets.kSymmetricV24,
      child: BlocBuilder<BonusesBloc, BonusesState>(
        builder: (_, state) => state.maybeWhen(
          loaded: (bonuses, _) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: AppSizes.kGeneral4.toInt(),
                child: InkWell(
                  onTap: () => _goToBonuses(context),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BonusesDataWidget(),
                      AppBoxes.kBoxV8,
                      PrepaidWaterDataWidget(),
                    ],
                  ),
                ),
              ),
              AppBoxes.kBoxH8,
              Flexible(
                flex: AppSizes.kGeneral6.toInt(),
                child: InkWell(
                  onTap: () => _goToBonuses(context),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(
                      AppSizes.kGeneral12,
                      AppSizes.kGeneral12,
                      AppSizes.kGeneral8,
                      AppSizes.kGeneral8,
                    ),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: bonuses.level.cardImage.provider(),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(AppSizes.kGeneral12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Assets.images.logo.svg(height: AppSizes.kGeneral16),
                        AppBoxes.kBoxV24,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: LevelNameWidget(
                                level: bonuses.level.toLocale(),
                              ),
                            ),
                            AppBoxes.kBoxH12,
                            QRCodeButton(data: bonuses.cardNumber),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          unauthorized: UnauthorizedBonusesWidget.new,
          orElse: SizedBox.shrink,
        ),
      ),
    );
  }
}
