import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

@RoutePage()
class CleaningOrderSuccessfulPage extends StatelessWidget {
  const CleaningOrderSuccessfulPage({super.key});

  void _goToProfile(BuildContext context) {
    context.router
        .popUntil((route) => route.settings.name == ProfileRoute.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: AppInsets.kHorizontal16,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: AppInsets.kHorizontal72,
                    child: Assets.images.greenCheck.image(),
                  ),
                  AppBoxes.kHeight16,
                  Text(
                    t.equipments.applicationAccepted,
                    style: context.textStyle.headingTypo.h3
                        .withColor(context.colors.textColors.main),
                  ),
                  AppBoxes.kHeight12,
                  Text(
                    t.equipments.expectCallFromManager,
                    style: context.textStyle.textTypo.tx1Medium
                        .withColor(context.colors.textColors.secondary),
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: AppInsets.kAll16,
                decoration: BoxDecoration(
                  color: context.colors.mainColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: context.colors.textColors.main
                          .withOpacity(AppSizes.kShadowOpacity),
                      offset: AppConstants.kShadowTop,
                      blurRadius: AppSizes.kGeneral12,
                    ),
                  ],
                ),
                child: AppTextButton.primary(
                  text: t.equipments.goBackToProfile,
                  onTap: () => _goToProfile(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
