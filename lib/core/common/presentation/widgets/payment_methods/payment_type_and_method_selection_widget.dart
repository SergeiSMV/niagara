import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/payment_methods/widget/payment_method_selection_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/payment_methods/widget/payment_type_selection_widget.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';

/// Виджет для выбора типа и метода оплаты.
///
/// Позволяет выбирать тип оплаты - "онлайн" или "курьеру" и доступны в рамках
/// выбранного типа метода оплаты.
class PaymentTypeAndMethodSelectionWidget extends StatelessWidget {
  const PaymentTypeAndMethodSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kAll4,
      child: Column(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: context.colors.mainColors.bgCard,
              borderRadius: AppBorders.kCircular12,
            ),
            child: const PaymentTypeSelectionWidget(),
          ),
          AppBoxes.kHeight12,
          const PaymentMethodSelectionWidget(),
        ],
      ),
    );
  }
}
