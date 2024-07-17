import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';

class ProposalItemWidget extends StatelessWidget {
  const ProposalItemWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppInsets.kAll4,
      padding: AppInsets.kHorizontal12 + AppInsets.kVertical8,
      decoration: BoxDecoration(
        borderRadius: AppBorders.kCircular6,
        color: context.colors.mainColors.bgCard,
      ),
      child: Text(
        text,
        style: context.textStyle.textTypo.tx2Medium
            .withColor(context.colors.textColors.main),
      ),
    );
  }
}
