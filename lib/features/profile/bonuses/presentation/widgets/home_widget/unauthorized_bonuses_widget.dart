import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
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
      padding: AppConst.kCommon12.horizontal + AppConst.kCommon16.vertical,
      decoration: BoxDecoration(
        color: context.colors.mainColors.white,
        borderRadius: BorderRadius.circular(AppConst.kCommon12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.bonuses.loginOrRegister,
            style: context.textStyle.headingTypo.h3
                .withColor(context.colors.textColors.main),
          ).padding(right: AppConst.kCommon24),
          AppConst.kCommon8.verticalBox,
          Text(
            t.bonuses.loginOrRegisterDescription,
            style: context.textStyle.textTypo.tx2Medium
                .withColor(context.colors.textColors.secondary),
          ),
          AppConst.kCommon24.verticalBox,
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
