import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class UnauthorizedBonusesWidget extends StatelessWidget {
  const UnauthorizedBonusesWidget({super.key});

  void _navigateToLogin(BuildContext context) =>
      context.navigateTo(const AuthWrapper());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppInsets.kSymmetricH12 + AppInsets.kSymmetricV16,
      decoration: BoxDecoration(
        color: context.colors.mainColors.white,
        borderRadius: BorderRadius.circular(AppSizes.kGeneral12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: AppInsets.kOnlyRight24,
            child: Text(
              t.bonuses.loginOrRegister,
              style: context.textStyle.headingTypo.h3
                  .withColor(context.colors.textColors.main),
            ),
          ),
          AppBoxes.kBoxV8,
          Text(
            t.bonuses.loginOrRegisterDescription,
            style: context.textStyle.textTypo.tx2Medium
                .withColor(context.colors.textColors.secondary),
          ),
          AppBoxes.kBoxV24,
          AppTextButton.primary(
            text: t.bonuses.login,
            icon: Assets.icons.login,
            onTap: () => _navigateToLogin(context),
          ),
        ],
      ),
    );
  }
}
