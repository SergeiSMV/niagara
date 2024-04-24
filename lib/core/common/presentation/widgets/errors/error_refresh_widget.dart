import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class ErrorRefreshWidget extends StatelessWidget {
  const ErrorRefreshWidget({
    required this.error,
    required this.onRefresh,
    super.key,
  });

  final String error;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Text(
          error,
          style: context.textStyle.textTypo.tx1Medium
              .withColor(context.colors.textColors.secondary),
        ),
        const Spacer(flex: 2),
        SafeArea(
          child: AppTextButton.primary(
            text: t.common.refresh,
            onTap: onRefresh,
          ).paddingAll(AppConst.kCommon16),
        ),
      ],
    );
  }
}
