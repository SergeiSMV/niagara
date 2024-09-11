import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Кнопка оплаты.
///
/// Отображает сумму покупки, текст и количество товаров, если оно указано.
class PaymentButton extends StatelessWidget {
  const PaymentButton({
    super.key,
    required this.amountRub,
    required this.buttonText,
    required this.onTap,
    this.productCount,
  });

  /// Сумма покупки в рублях.
  final String amountRub;

  /// Текст, отображающий количество товаров.
  ///
  /// Например, "1 товар" или "2 товара".
  final int? productCount;

  /// Текст кнопки.
  final String buttonText;

  /// Коллбэк, вызываемый при нажатии на кнопку.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.mainColors.white,
        boxShadow: [
          BoxShadow(
            color: context.colors.textColors.main
                .withOpacity(AppSizes.kShadowOpacity),
            blurRadius: AppSizes.kGeneral12,
            offset: AppConstants.kShadowTop,
          ),
        ],
      ),
      child: Padding(
        padding:
            AppInsets.kHorizontal16 + AppInsets.kTop12 + AppInsets.kBottom24,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
              alignment: Alignment.center,
              padding: AppInsets.kHorizontal16,
              decoration: BoxDecoration(
                color: context.colors.buttonColors.primary,
                borderRadius: AppBorders.kCircular12,
              ),
              height: AppSizes.kButtonLarge,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (productCount != null)
                    Text(
                      t.product(n: productCount!),
                      style: context.textStyle.textTypo.tx2Medium
                          .withColor(context.colors.textColors.white),
                    ),
                  Text(
                    buttonText,
                    style: context.textStyle.buttonTypo.btn1bold
                        .withColor(context.colors.textColors.white),
                  ),
                  Text(
                    '$amountRub ${t.common.rub}',
                    style: context.textStyle.textTypo.tx2Medium
                        .withColor(context.colors.textColors.white),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
