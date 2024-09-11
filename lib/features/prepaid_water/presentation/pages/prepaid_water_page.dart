import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/prepaid_water/presentation/widgets/prepaid_water_balance_widget.dart';
import 'package:niagara_app/features/prepaid_water/presentation/widgets/prepaid_water_description.dart';

/// Страница баланса предоплатной воды.
@RoutePage()
class PrepaidWaterPage extends StatelessWidget {
  const PrepaidWaterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(),
      body: Stack(
        children: [
          _Background(),
          _Content(),
        ],
      ),
      // TODO(kvbykov): Рисуем кнопку только при непустом балансе.
      // https://digitalburo.youtrack.cloud/issue/NIAGARA-337/Logika.-Predoplatnaya-voda
      // bottomNavigationBar: _AddToCartButton(),
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
            child: const PrepaidWaterBalanceWidget(),
          ),
        ],
      ),
    );
  }
}

/// Кнопка "Добавить в корзину" внизу экрана.
class _AddToCartButton extends StatelessWidget {
  const _AddToCartButton();

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
          text: t.prepaidWater.addToCart,
          onTap: () {},
        ),
      ),
    );
  }
}
