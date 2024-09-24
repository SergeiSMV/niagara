import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class AboutBonusProgramButton extends StatelessWidget {
  const AboutBonusProgramButton({super.key});

  void _navigateToAboutProgram(BuildContext context) =>
      context.navigateTo(const AboutBonusesRoute());

  @override
  Widget build(BuildContext context) {
    final color = context.colors.textColors.accent;
    final style = context.textStyle.buttonTypo.btn2semiBold.withColor(color);

    return InkWell(
      onTap: () => _navigateToAboutProgram(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            t.bonuses.aboutBonuses,
            style: style,
          ),
          Assets.icons.arrowRight.svg(
            width: AppSizes.kIconSmall,
            height: AppSizes.kIconSmall,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
        ],
      ),
    );
  }
}
