import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/bonuses.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/bonus_data/horizontal_bonus_cards_data_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/home_widget/qr_code_button.dart';

class BasicStatusWidget extends StatelessWidget {
  const BasicStatusWidget({
    super.key,
    required this.bonuses,
  });

  final Bonuses bonuses;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kHorizontal16 + AppInsets.kVertical24,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _BasicStatusQRWidget(bonuses: bonuses),
          AppBoxes.kHeight8,
          const HorizontalBonusCardsDataWidget(),
        ],
      ),
    );
  }
}

class _BasicStatusQRWidget extends StatelessWidget {
  const _BasicStatusQRWidget({
    required this.bonuses,
  });

  final Bonuses bonuses;

  void _goToBonuses(BuildContext context) =>
      context.navigateTo(const MyBonusesRoute());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _goToBonuses(context),
      child: Container(
        padding: AppInsets.kHorizontal12 + AppInsets.kVertical16,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: bonuses.level.cardImage.provider(),
            fit: BoxFit.cover,
          ),
          borderRadius: AppBorders.kCircular12,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${bonuses.level.toLocale} ${t.bonuses.status.toLowerCase()}',
                    style: context.textStyle.textTypo.tx1SemiBold.withColor(
                      context.colors.textColors.white,
                    ),
                  ),
                  AppBoxes.kHeight24,
                  Row(
                    children: [
                      Text(
                        t.bonuses.readMoreAboutStatus,
                        style:
                            context.textStyle.buttonTypo.btn3semiBold.withColor(
                          context.colors.textColors.white,
                        ),
                      ),
                      Assets.icons.arrowRight.svg(
                        width: AppSizes.kIconSmall,
                        height: AppSizes.kIconSmall,
                        colorFilter: ColorFilter.mode(
                          context.colors.textColors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            AppBoxes.kWidth12,
            QRCodeButton(data: bonuses.cardNumber),
          ],
        ),
      ),
    );
  }
}
