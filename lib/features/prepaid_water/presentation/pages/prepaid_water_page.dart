import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/catalog/domain/model/group.dart';
import 'package:niagara_app/features/prepaid_water/presentation/bloc/balance_cubit/water_balance_cubit.dart';
import 'package:niagara_app/features/prepaid_water/presentation/widgets/prepaid_water_description.dart';
import 'package:niagara_app/features/prepaid_water/presentation/widgets/water_balance_product_list.dart';

/// Страница баланса предоплатной воды.
@RoutePage()
class PrepaidWaterPage extends StatelessWidget {
  const PrepaidWaterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: const Stack(
        children: [
          _Background(),
          _Content(),
        ],
      ),
      // Кнопка рисуется только при непустом балансе.
      bottomNavigationBar: Builder(
        builder: (context) {
          final bool isEmpty =
              context.select((WaterBalanceCubit cubit) => cubit.count == 0);

          return isEmpty ? const SizedBox.shrink() : const _GoToCartButton();
        },
      ),
    );
  }
}

/// Фон страницы. Содержит изображение и баннер с информацией о программе.
class _Background extends StatelessWidget {
  const _Background();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Фоновое изображение.
        Assets.images.prepaidWaterBG.image(),

        // Баннер с информацией о программе.
        const Positioned(
          top: AppSizes.kGeneral24,
          left: AppSizes.kGeneral16,
          right: AppSizes.kGeneral16,
          child: PrepaidWaterDescriptionBanner(),
        ),
      ],
    );
  }
}

/// Контент страницы - карточки товаров.
class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Пустое пространство, нужное, чтобы часть [_Background] была видна.
          SizedBox(height: context.screenWidth * 0.82),

          // Описание программы страницы.
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              color: context.colors.mainColors.white,
            ),
            child: const WaterBalanceProductList(),
          ),
        ],
      ),
    );
  }
}

/// Кнопка "Перейти в корзигу" внизу экрана.
class _GoToCartButton extends StatelessWidget {
  const _GoToCartButton();

  void _goToWaterPromotions(BuildContext context) {
    final String? groupId = context.read<WaterBalanceCubit>().bottlesGroupId;
    final group = Group.forWater(groupId);
    PageRouteInfo? redirectRoute;

    if (group != null) {
      redirectRoute = CategoryWrapperRoute(
        group: group,
        children: const [CategoryRoute()],
      );
    }

    if (redirectRoute != null) {
      context.navigateTo(redirectRoute);
    } else {
      context.navigateTo(const CatalogWrapper());
    }
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.mainColors.white,
        boxShadow: [
          BoxShadow(
            color: context.colors.textColors.main
                .withOpacity(AppSizes.kShadowOpacity),
            blurRadius: AppSizes.kGeneral12,
            offset: AppConstants.kShadowTop,
          ),
        ],
      ),
      child: Padding(
        padding:
            AppInsets.kHorizontal16 + AppInsets.kBottom24 + AppInsets.kTop12,
        child: AppTextButton.primary(
          text: t.prepaidWater.goShopping,
          onTap: () => _goToWaterPromotions(context),
        ),
      ),
    );
  }
}
