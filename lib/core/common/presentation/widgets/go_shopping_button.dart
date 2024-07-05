import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class GoShoppingButton extends StatelessWidget {
  const GoShoppingButton({super.key});

  void _navigateToCatalog(BuildContext context) =>
      context.navigateTo(const CatalogWrapper());

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
        padding: AppInsets.kHorizontal16 +
            AppInsets.kVertical12 +
            AppInsets.kBottom12,
        child: AppTextButton.primary(
          text: t.favorites.goShopping,
          onTap: () => _navigateToCatalog(context),
        ),
      ),
    );
  }
}
