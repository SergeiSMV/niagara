import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class DeleteProductsButtonWidget extends StatelessWidget {
  const DeleteProductsButtonWidget({
    super.key,
    required this.onTap,
    this.unavailable = false,
  });

  final VoidCallback onTap;
  final bool unavailable;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: AppInsets.kAll2,
        child: Text(
          unavailable ? t.cart.clearUnavailable : t.cart.clearCart,
          style: context.textStyle.textTypo.tx2Medium
              .withColor(context.colors.textColors.error),
        ),
      ),
    );
  }
}
