import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/presentation/router/app_router.gr.dart';
import '../../../../core/utils/constants/app_borders.dart';
import '../../../../core/utils/constants/app_boxes.dart';
import '../../../../core/utils/constants/app_insets.dart';
import '../../../../core/utils/constants/app_sizes.dart';
import '../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../core/utils/gen/assets.gen.dart';
import '../../../../core/utils/gen/strings.g.dart';
import '../bloc/balance_cubit/water_balance_cubit.dart';

/// Баннер для перехода на страницу предоплатной воды.
///
/// Отображает количество доступной предоплатной воды на балансе.
class PrepaidWaterBanner extends StatelessWidget {
  const PrepaidWaterBanner({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<WaterBalanceCubit, WaterBalanceState>(
        builder: (context, state) => state.maybeWhen(
          loaded: (balance) => _Banner(count: balance.count),
          empty: () => const _Banner(count: 0),
          orElse: SizedBox.shrink,
        ),
      );
}

/// Виджет для отображения баннера предоплатной воды
class _Banner extends StatelessWidget {
  const _Banner({
    required this.count,
  });

  /// Число бутылей на балансе.
  final int count;

  /// Перенаправляет на страницу баланса предоплатной воды.
  void _navigateToPrepaidWater(BuildContext context) => context.navigateTo(
        const LoyaltyProgramWrapper(
          children: [
            PrepaidWaterRoute(),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) => Padding(
        padding: AppInsets.kHorizontal16 + AppInsets.kBottom24,
        child: GestureDetector(
          onTap: () => _navigateToPrepaidWater(context),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: AppBorders.kCircular8,
              color: context.colors.mainColors.white,
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: AppBorders.kCircular8,
                  child: Assets.images.prepaidWaterSideBanner.image(
                    width: AppSizes.kImageSize110,
                  ),
                ),
                AppBoxes.kWidth12,
                Column(
                  children: [
                    Text(
                      t.prepaidWater.title,
                      style: context.textStyle.textTypo.tx2SemiBold,
                    ),
                    AppBoxes.kHeight4,
                    Text(
                      t.prepaidWater.onBalanceCount(count: count),
                      style: context.textStyle.textTypo.tx2Medium,
                    ),
                  ],
                ),
                const Spacer(),
                Assets.icons.arrowRight.svg(
                  width: AppSizes.kIconMedium,
                  height: AppSizes.kIconMedium,
                ),
                AppBoxes.kWidth8,
              ],
            ),
          ),
        ),
      );
}
