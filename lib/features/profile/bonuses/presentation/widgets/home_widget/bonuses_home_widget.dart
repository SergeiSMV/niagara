import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
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
    return BlocBuilder<BonusesBloc, BonusesState>(
      builder: (_, state) => state
          .maybeWhen(
            loaded: (bonuses, _) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: AppConst.kCommon4.toInt(),
                  child: InkWell(
                    onTap: () => _goToBonuses(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BonusesDataWidget(),
                        AppConst.kCommon8.verticalBox,
                        const PrepaidWaterDataWidget(),
                      ],
                    ),
                  ),
                ),
                AppConst.kCommon8.horizontalBox,
                Flexible(
                  flex: AppConst.kCommon6.toInt(),
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
                          image: bonuses.level.cardImage.provider(),
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
                                child: LevelNameWidget(
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
            unauthorized: UnauthorizedBonusesWidget.new,
            orElse: SizedBox.shrink,
          )
          .paddingSymmetric(
            vertical: AppConst.kCommon24,
            horizontal: AppConst.kCommon16,
          ),
    );
  }
}
