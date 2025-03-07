import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class ProductShortDescription extends StatelessWidget {
  const ProductShortDescription({
    required this.product,
    required this.isWaterBalance,
  });

  final Product product;
  final bool isWaterBalance;

  @override
  Widget build(BuildContext context) {
    final bool displaySecondPart =
        product.discountOfCount.isNotEmpty && !isWaterBalance;
    final bool isEmpty = product.description.isEmpty && !displaySecondPart;

    if (isEmpty) return const SizedBox.shrink();

    return RichText(
      maxLines: AppConstants.kMaxLines1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          if (product.description.isNotEmpty)
            TextSpan(
              text: product.description +
                  (displaySecondPart ? t.common.dotSeparator : ''),
              style: context.textStyle.descriptionTypo.des3.copyWith(
                color: context.colors.textColors.secondary,
              ),
            ),
          if (displaySecondPart)
            TextSpan(
              text: product.discountOfCount,
              style: context.textStyle.captionTypo.c1.withColor(
                context.colors.infoColors.green,
              ),
            ),
        ],
      ),
    );
  }
}
