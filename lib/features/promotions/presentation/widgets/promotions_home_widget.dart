import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/presentation/router/app_router.gr.dart';
import '../../../../core/utils/constants/app_boxes.dart';
import '../../../../core/utils/constants/app_insets.dart';
import '../../../../core/utils/constants/app_sizes.dart';
import '../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../core/utils/extensions/text_style_ext.dart';
import '../../../../core/utils/gen/assets.gen.dart';
import '../../../../core/utils/gen/strings.g.dart';
import '../cubit/promotions_cubit.dart';
import 'promotions_widget.dart';

/// Виджет для отображения промо на главной странице
class PromotionsHomeWidget extends StatelessWidget {
  const PromotionsHomeWidget({super.key});

  /// Переход на страницу всех промо
  void _navigateToAllPromotions(BuildContext context) =>
      context.navigateTo(PromotionsRoute(isPersonal: false));

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<PromotionsCubit, PromotionsState>(
        builder: (_, state) => state.map(
          loading: (_) => Center(
            child: Padding(
              padding: AppInsets.kVertical64 + AppInsets.kVertical2,
              child: Assets.lottie.loadCircle.lottie(
                width: AppSizes.kGeneral64,
                height: AppSizes.kGeneral64,
                repeat: true,
              ),
            ),
          ),
          loaded: (state) => ColoredBox(
            color: context.colors.mainColors.white,
            child: Column(
              children: [
                AppBoxes.kHeight32,
                Padding(
                  padding: AppInsets.kHorizontal16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        t.promos.promotions,
                        style: context.textStyle.headingTypo.h3
                            .withColor(context.colors.textColors.main),
                      ),
                      InkWell(
                        onTap: () => _navigateToAllPromotions(context),
                        child: Row(
                          children: [
                            Text(
                              t.common.all,
                              style: context.textStyle.buttonTypo.btn3semiBold
                                  .withColor(context.colors.textColors.accent),
                            ),
                            Assets.icons.arrowRight.svg(
                              width: AppSizes.kIconSmall,
                              height: AppSizes.kIconSmall,
                              colorFilter: ColorFilter.mode(
                                context.colors.textColors.accent,
                                BlendMode.srcIn,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const PromotionsWidget(),
              ],
            ),
          ),
          error: (_) => const SizedBox.shrink(),
        ),
      );
}
