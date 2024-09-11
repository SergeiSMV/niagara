import 'package:flutter/widgets.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/activation_option.dart';

/// Виджет с описанием преопбретаемой подписки. Используется для отображения
/// на странице покупки ВИП-подписки.
///
/// Отображает заголовок и описание.
class VipPurchaseDescription extends StatelessWidget {
  const VipPurchaseDescription({
    super.key,
    required this.option,
  });

  final ActivationOption option;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.mainColors.bgCard,
        borderRadius: AppBorders.kCircular12,
      ),
      child: Padding(
        padding: AppInsets.kHorizontal12 + AppInsets.kVertical16,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              option.title,
              style: context.textStyle.textTypo.tx1SemiBold,
            ),
            AppBoxes.kHeight8,
            Text(
              option.descriptionFull,
              style: context.textStyle.textTypo.tx2Medium.withColor(
                context.colors.textColors.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
