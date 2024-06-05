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
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/home_widget/level_name_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/home_widget/qr_code_button.dart';

class BasicStatusWidget extends StatelessWidget {
  const BasicStatusWidget({
    super.key,
    required this.bonuses,
  });

  final Bonuses bonuses;

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: AppSizes.kGeneral4.toInt(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => _goToBonuses(context),
                child: const BonusesDataWidget(),
              ),
              AppBoxes.kHeight8,
              InkWell(
                onTap: () {},
                child: const PrepaidWaterDataWidget(),
              ),
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
                children: [
                  Assets.images.logo.svg(height: AppSizes.kGeneral16),
                  AppBoxes.kHeight24,
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
    );
  }
}
