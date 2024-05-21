import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class SearchBarBackButton extends StatelessWidget {
  const SearchBarBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.maybePop(),
      child: Padding(
        padding: AppInsets.kRight16,
        child: Text(
          t.common.cancel,
          style: context.textStyle.textTypo.tx3SemiBold
              .withColor(context.colors.textColors.accent),
        ),
      ),
    );
  }
}
