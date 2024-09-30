import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class CartDataWidget extends StatelessWidget {
  const CartDataWidget({
    super.key,
    required this.title,
    required this.data,
    this.isBold = false,
  });

  final String title;
  final num data;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    if (data == 0) return const SizedBox.shrink();
    final typo = context.textStyle.textTypo;
    final textStyle = isBold ? typo.tx2SemiBold : typo.tx2Medium;
    final textColor = context.colors.textColors.main;
    return Padding(
      padding: AppInsets.kVertical4,
      child: Row(
        children: [
          Text(
            title,
            style: textStyle.withColor(textColor),
          ),
          const Spacer(),
          Text(
            '${data.round()} ${t.common.rub}',
            style: textStyle.withColor(textColor),
          ),
        ],
      ),
    );
  }
}
