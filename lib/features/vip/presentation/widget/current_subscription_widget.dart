import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Виджет, отображающий информацию (дату окончания) о текущей подписке.
class CurrentSubscriptionWidget extends StatelessWidget {
  const CurrentSubscriptionWidget({
    required this.endDate,
    super.key,
  });

  /// Дата окончания подписки.
  final String endDate;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: AppBorders.kCircular12,
        color: context.colors.mainColors.bgCard,
      ),
      child: Padding(
        padding: AppInsets.kAll12,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: context.colors.infoColors.green,
                borderRadius: AppBorders.kCircular4,
              ),
              child: Padding(
                padding: AppInsets.kHorizontal10 + AppInsets.kVertical6,
                child: Text(
                  t.vip.currentSubscription,
                  style: context.textStyle.captionTypo.c1.withColor(
                    context.colors.textColors.white,
                  ),
                ),
              ),
            ),
            AppBoxes.kHeight8,
            Text(
              t.vip.activeUntil(date: endDate),
              style: context.textStyle.textTypo.tx1SemiBold,
            ),
          ],
        ),
      ),
    );
  }
}
