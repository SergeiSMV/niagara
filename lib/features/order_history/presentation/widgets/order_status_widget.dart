import 'package:flutter/material.dart';

import '../../../../core/utils/constants/app_borders.dart';
import '../../../../core/utils/constants/app_insets.dart';
import '../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../core/utils/extensions/color_ext.dart';
import '../../../../core/utils/extensions/text_style_ext.dart';
import '../../domain/models/user_order.dart';

/// Виджет статуса заказа
class OrderStatusWidget extends StatelessWidget {
  const OrderStatusWidget({
    required this.order,
    super.key,
    this.padding = AppInsets.kHorizontal4,
  });

  /// Заказ
  final UserOrder order;

  /// Отступы
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) => Container(
        padding: padding + AppInsets.kVertical6,
        decoration: BoxDecoration(
          borderRadius: AppBorders.kCircular4,
          color: HexColor.fromHex(order.orderStatusHex),
        ),
        child: Text(
          order.orderStatus,
          style: context.textStyle.captionTypo.c1.withColor(
            context.colors.mainColors.white,
          ),
        ),
      );
}
