import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/bonuses.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/home_widget/qr_code_button.dart';

class SpecialStatusQRWidget extends StatelessWidget {
  const SpecialStatusQRWidget({
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
    return InkWell(
      onTap: () => _goToBonuses(context),
      child: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: bonuses.level.cardImage.provider(),
            fit: BoxFit.fill,
          ),
          borderRadius: AppBorders.kCircular12,
        ),
        child: Padding(
          padding: AppInsets.kHorizontal12 + AppInsets.kVertical16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      bonuses.level.statusIcon.image(
                        width: AppSizes.kGeneral24,
                        height: AppSizes.kGeneral24,
                      ),
                      AppBoxes.kWidth8,
                      Text(
                        bonuses.level.toLocale,
                        style: context.textStyle.headingTypo.h2.withColor(
                          context.colors.mainColors.white,
                        ),
                      ),
                    ],
                  ),
                  AppBoxes.kWidth12,
                  QRCodeButton(data: bonuses.cardNumber),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
