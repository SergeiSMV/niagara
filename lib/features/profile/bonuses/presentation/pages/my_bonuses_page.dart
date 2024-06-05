import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/errors/error_refresh_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/common/presentation/widgets/modals/modal_background_widget.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/bloc/bonuses_bloc/bonuses_bloc.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/accrued_bonuses_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/benefits/list_benefits_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/bonus_data/about_bonus_program_button.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/bonus_data/bonus_level_status_data_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/bonuses_footer_button.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/next_level_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/yearly_bonuses_widget.dart';

@RoutePage()
class MyBonusesPage extends StatelessWidget {
  const MyBonusesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBarWidget(),
              SliverToBoxAdapter(child: _Content()),
            ],
          ),
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  void _onRefresh(BuildContext context) =>
      context.read<BonusesBloc>().add(const BonusesEvent.started());

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BonusesBloc, BonusesState>(
      builder: (_, state) => state.when(
        loading: () => const AppCenterLoader(),
        loaded: (_, __) => Stack(
          children: [
            const BonusLevelStatusDataWidget(),
            Column(
              children: [
                const SizedBox(height: 200),
                ModalBackgroundWidget(
                  child: BlocBuilder<BonusesBloc, BonusesState>(
                    builder: (_, state) => state.maybeWhen(
                      orElse: () => const SizedBox.shrink(),
                      loaded: (bonuses, _) => Padding(
                        padding: AppInsets.kHorizontal16,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppBoxes.kHeight24,
                            Text(
                              t.bonuses.yourBenefits,
                              style: context.textStyle.headingTypo.h3.withColor(
                                context.colors.textColors.main,
                              ),
                            ),
                            AppBoxes.kHeight16,
                            const ListBenefitsWidget(),
                            if (bonuses.level.isBasicStatus)
                              Column(
                                children: [
                                  const Padding(
                                    padding: AppInsets.kVertical16,
                                    child: Column(
                                      children: [
                                        YearlyBonusesWidget(),
                                        AppBoxes.kHeight12,
                                        AccruedBonusesWidget(),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: AppInsets.kVertical16,
                                    child: Column(
                                      children: [
                                        Text(
                                          t.bonuses.morePurchases,
                                          style: context
                                              .textStyle.headingTypo.h3
                                              .withColor(
                                            context.colors.textColors.main,
                                          ),
                                        ),
                                        AppBoxes.kHeight16,
                                        const NextLevelWidget(),
                                        AppBoxes.kHeight24,
                                        const AboutBonusProgramButton(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            Column(
                              children: [
                                if (bonuses.level.isBasicStatus)
                                  Column(
                                    children: [
                                      BonusesFooterButton(
                                        icon: Assets.icons.info,
                                        title: t.bonuses.bonusesFaqs,
                                        onTap: () {},
                                      ),
                                      Divider(
                                        height: 0,
                                        color: context
                                            .colors.otherColors.separator30,
                                        thickness: AppSizes.kGeneral1,
                                      ),
                                    ],
                                  ),
                                BonusesFooterButton(
                                  icon: Assets.icons.support,
                                  title: t.bonuses.contactUs,
                                  onTap: () {},
                                ),
                                Divider(
                                  height: 0,
                                  color: context.colors.otherColors.separator30,
                                  thickness: AppSizes.kGeneral1,
                                ),
                                AppBoxes.kHeight48,
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        unauthorized: () => const SizedBox.shrink(),
        error: (_) => ErrorRefreshWidget(
          onRefresh: () => _onRefresh(context),
        ),
      ),
    );
  }
}
