import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class ProductExpandablePropertiesWidget extends HookWidget {
  const ProductExpandablePropertiesWidget({
    super.key,
    required this.properties,
    this.maxLines = 3,
  });

  final List<ProductProperty> properties;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);

    final buttonText =
        isExpanded.value ? t.catalog.showLess : t.catalog.showFull;

    final nameTStyle = context.textStyle.descriptionTypo.des2;
    final valueTSstyle = context.textStyle.textTypo.tx2Medium;

    final nameTColor = context.colors.textColors.secondary;
    final valueTColor = context.colors.textColors.main;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...properties.take(isExpanded.value ? properties.length : maxLines).map(
              (property) => Column(
                children: [
                  Padding(
                    padding: AppInsets.kVertical8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            property.name,
                            style: nameTStyle.withColor(nameTColor),
                          ),
                        ),
                        AppBoxes.kWidth16,
                        Flexible(
                          child: Text(
                            property.value,
                            style: valueTSstyle.withColor(valueTColor),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (properties.indexOf(property) != properties.length - 1)
                    Divider(
                      height: AppSizes.kGeneral2,
                      thickness: AppSizes.kGeneral1,
                      color: context.colors.otherColors.separator30,
                    ),
                ],
              ),
            ),
        if (properties.length > maxLines)
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBoxes.kHeight12,
              InkWell(
                onTap: () => isExpanded.value = !isExpanded.value,
                child: Row(
                  children: [
                    Text(
                      buttonText,
                      style: context.textStyle.textTypo.tx3SemiBold
                          .withColor(context.colors.textColors.accent),
                    ),
                    AppBoxes.kWidth2,
                    RotatedBox(
                      quarterTurns: isExpanded.value ? 3 : 1,
                      child: Assets.icons.arrowRight.svg(
                        width: AppSizes.kIconSmall,
                        height: AppSizes.kIconSmall,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }
}
