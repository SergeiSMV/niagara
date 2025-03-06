import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/bonuses.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/bonus_data/bonuses_data_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/bonus_data/prepaid_water_data_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/bonus_data/temporary_bonuses_data_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/home_widget/level_name_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/home_widget/qr_code_button.dart';

class BasicStatusWidget extends StatelessWidget {
  const BasicStatusWidget({
    super.key,
    required this.bonuses,
  });

  final Bonuses bonuses;

  /// Переходит на страницу бонусов.
  void _goToBonuses(BuildContext context) => context.navigateTo(
        const LoyaltyProgramWrapper(
          children: [
            MyBonusesRoute(),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.kGeneral138,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: AppSizes.kGeneral4.toInt(),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: AppSizes.kGeneral72,
                  child: Row(
                    children: [
                      Flexible(child: BonusesDataWidget()),
                      AppBoxes.kWidth6,
                      Flexible(child: TemporaryBonusesDataWidget()),
                    ],
                  ),
                ),
                PrepaidWaterDataWidget(),
              ],
            ),
          ),
          AppBoxes.kWidth8,
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
                  borderRadius: AppBorders.kCircular12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Assets.images.logo.svg(height: AppSizes.kGeneral16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: AppSizes.kGeneral8.toInt(),
                          child: LevelNameWidget(
                            level:
                                '${bonuses.level.toLocale} ${t.bonuses.status.toLowerCase()}',
                          ),
                        ),
                        const Spacer(),
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
    );
  }
}
