import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class DeleteProductsButtonWidget extends StatelessWidget {
  const DeleteProductsButtonWidget({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        t.common.delete,
        style: context.textStyle.textTypo.tx2Medium
            .withColor(context.colors.textColors.error),
      ),
    );
  }
}
