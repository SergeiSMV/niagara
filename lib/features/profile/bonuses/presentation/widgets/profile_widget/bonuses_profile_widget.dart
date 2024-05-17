import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/bloc/bonuses_bloc/bonuses_bloc.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/bonus_data/horizontal_bonus_cards_data_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/home_widget/qr_code_button.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/home_widget/unauthorized_bonuses_widget.dart';

class BonusesProfileWidget extends StatelessWidget {
  const BonusesProfileWidget({super.key});

  void _goToBonuses(BuildContext context) =>
      context.navigateTo(const MyBonusesRoute());

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BonusesBloc, BonusesState>(
      builder: (_, state) => state.maybeWhen(
        loaded: (bonuses, _) => Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => _goToBonuses(context),
              child: Container(
                padding:
                    AppConst.kCommon12.horizontal + AppConst.kCommon16.vertical,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: bonuses.level.cardImage.provider(),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(AppConst.kCommon12),
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
                            bonuses.level.toLocale(),
                            style: context.textStyle.textTypo.tx1SemiBold
                                .withColor(
                              context.colors.textColors.white,
                            ),
                          ),
                          AppConst.kCommon24.verticalBox,
                          Row(
                            children: [
                              Text(
                                t.bonuses.readMoreAboutStatus,
                                style: context.textStyle.buttonTypo.btn3semiBold
                                    .withColor(
                                  context.colors.textColors.white,
                                ),
                              ),
                              Assets.icons.arrowRight.svg(
                                width: AppConst.kIconSmall,
                                height: AppConst.kIconSmall,
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
                    AppConst.kCommon12.horizontalBox,
                    QRCodeButton(data: bonuses.cardNumber),
                  ],
                ),
              ),
            ),
            AppConst.kCommon8.verticalBox,
            const HorizontalBonusCardsDataWidget(),
          ],
        ).paddingSymmetric(
          vertical: AppConst.kCommon24,
          horizontal: AppConst.kCommon16,
        ),
        unauthorized: () => Stack(
          children: [
            Assets.images.unauthProfile.image(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Assets.images.logo.svg().paddingSymmetric(
                      horizontal: AppConst.kCommon16,
                      vertical: AppConst.kCommon48,
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
