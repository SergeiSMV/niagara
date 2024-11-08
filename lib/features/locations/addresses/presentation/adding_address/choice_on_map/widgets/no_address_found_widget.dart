import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class NoAddressFoundWidget extends StatelessWidget {
  const NoAddressFoundWidget({super.key});

  void _onManualInput(BuildContext context) =>
      context.pushRoute(SearchAddressRoute());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kHorizontal16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Assets.icons.attention.svg(
                colorFilter: ColorFilter.mode(
                  context.colors.infoColors.red,
                  BlendMode.srcIn,
                ),
              ),
              AppBoxes.kWidth12,
              Padding(
                padding: AppInsets.kVertical24,
                child: Text(
                  t.locations.noAddressFound,
                  style: context.textStyle.textTypo.tx1SemiBold,
                ),
              ),
            ],
          ),
          AppTextButton.primary(
            text: t.locations.yeahThatsRight,
          ),
          Padding(
            padding: AppInsets.kVertical12,
            child: AppTextButton.secondary(
              text: t.locations.enterManually,
              onTap: () => _onManualInput(context),
            ),
          ),
          AppBoxes.kHeight12,
        ],
      ),
    );
  }
}
