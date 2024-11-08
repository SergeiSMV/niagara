import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/prepaid_water/presentation/widgets/prepaid_water_description.dart';

class ProductExpandableTextWidget extends HookWidget {
  const ProductExpandableTextWidget({
    super.key,
    required this.text,
    this.showPrepaidWaterBanner = false,
    this.maxLines = 6,
  });

  final String text;
  final int maxLines;
  final bool showPrepaidWaterBanner;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);

    final buttonText =
        isExpanded.value ? t.catalog.showLess : t.catalog.showFull;

    final textStyle = context.textStyle.descriptionTypo.des2;

    return LayoutBuilder(
      builder: (_, size) {
        final span = TextSpan(text: text, style: textStyle);
        final tp = TextPainter(
          text: span,
          maxLines: maxLines,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: size.maxWidth);

        if (tp.didExceedMaxLines) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedContainer(
                duration: Durations.medium1,
                height: isExpanded.value ? null : tp.height,
                child: Text(
                  text,
                  style: textStyle,
                  overflow: TextOverflow.fade,
                  maxLines: isExpanded.value ? null : maxLines,
                ),
              ),
              if (showPrepaidWaterBanner && isExpanded.value) ...[
                AppBoxes.kHeight24,
                PrepaidWaterDescriptionBanner(
                  backgroundColor: context.colors.mainColors.bgCard,
                ),
              ],
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
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(text, style: textStyle),
              if (showPrepaidWaterBanner) ...[
                AppBoxes.kHeight24,
                PrepaidWaterDescriptionBanner(
                  backgroundColor: context.colors.mainColors.bgCard,
                ),
              ],
            ],
          );
        }
      },
    );
  }
}
