import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class CleaningOrderButtonWidget extends StatelessWidget {
  const CleaningOrderButtonWidget({super.key});

  void _orderCleaning() {}

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
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
          text: t.equipments.orderCleaning,
          onTap: () => _orderCleaning(),
        ),
      ),
    );
  }
}
