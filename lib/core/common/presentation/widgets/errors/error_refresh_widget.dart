import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class ErrorRefreshWidget extends StatelessWidget {
  const ErrorRefreshWidget({
    this.error,
    required this.onRefresh,
    super.key,
  });

  final String? error;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          AppBoxes.kHeight24,
          Text(
            error ?? t.common.commonError,
            style: context.textStyle.textTypo.tx1Medium
                .withColor(context.colors.textColors.main),
          ),
          AppBoxes.kHeight12,
          Padding(
            padding: AppInsets.kAll16,
            child: AppTextButton.primary(
              text: t.common.refresh,
              onTap: onRefresh,
            ),
          ),
        ],
      ),
    );
  }
}
