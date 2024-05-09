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
import 'package:niagara_app/features/profile/bonuses/presentation/bloc/bonuses_bloc.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/bonus_data/bonus_data_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/home_widget/qr_code_button.dart';

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
    return BlocBuilder<BonusesBloc, BonusesState>(
      builder: (_, state) => state
          .maybeWhen(
            orElse: SizedBox.shrink,
            loaded: (bonuses) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BonusDataWidget(
                        title: t.bonuses.bonuses,
                        value: bonuses.count.toString(),
                        icon: Assets.icons.coinNiagara,
                      ),
                      AppConst.kCommon8.verticalBox,
                      BonusDataWidget(
                        title: t.bonuses.temporary,
                        value: bonuses.tempCount.toString(),
                        icon: Assets.icons.fire,
                      ),
                    ],
                  ),
                ),
                AppConst.kCommon8.horizontalBox,
                Flexible(
                  flex: 5,
                  child: InkWell(
                    onTap: () => _goToBonuses(context),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(
                        AppConst.kCommon12,
                        AppConst.kCommon12,
                        AppConst.kCommon8,
                        AppConst.kCommon8,
                      ),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: Assets.images.bonusStatus.silver.provider(),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(AppConst.kCommon12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Assets.images.logo.svg(height: AppConst.kCommon16),
                          AppConst.kCommon24.verticalBox,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: _LevelNameWidget(
                                  level: bonuses.level.toLocale(),
                                ),
                              ),
                              AppConst.kCommon12.horizontalBox,
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
          )
          .paddingSymmetric(
            vertical: AppConst.kCommon24,
            horizontal: AppConst.kCommon16,
          ),
    );
  }
}

class _LevelNameWidget extends StatelessWidget {
  const _LevelNameWidget({
    required this.level,
  });

  final String level;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: level,
        style: context.textStyle.textTypo.tx3SemiBold
            .withColor(context.colors.mainColors.white),
        children: [
          WidgetSpan(
            child: Assets.icons.arrowRight.svg(
              width: AppConst.kIconSmall,
              height: AppConst.kIconSmall,
              colorFilter: ColorFilter.mode(
                context.colors.mainColors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
      maxLines: AppConst.kCommon2.toInt(),
    );
  }
}
