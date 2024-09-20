import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Виджет, отображающий при пустом балансе предоплатной воды.
class EmptyWaterBalanceWidget extends StatelessWidget {
  const EmptyWaterBalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Assets.images.basket.image(
          width: AppSizes.kImageSize120,
          height: AppSizes.kImageSize120,
        ),
        AppBoxes.kHeight16,
        Text(
          t.prepaidWater.emptyBalance,
          style: context.textStyle.headingTypo.h3,
        ),
        AppBoxes.kHeight24,
        AppTextButton.primary(
          text: t.prepaidWater.goShopping,
          onTap: () => context.navigateTo(const CartWrapper()),
        ),
      ],
    );
  }
}
