import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/bloc/payment_method_selection_cubit/payment_method_selection_cubit.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/enums/payment_method_type.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Элемент списка выбора метода оплаты.
class PaymentMethodTile extends StatelessWidget {
  /// Конструирует виджет в зависимости от указанного метода оплаты.
  factory PaymentMethodTile.fromMethod({
    required PaymentMethod method,
    bool selectedByDefault = false,
  }) {
    switch (method) {
      case PaymentMethod.bankCard:
        return PaymentMethodTile.bankCard(selectedByDefault);
      case PaymentMethod.sbp:
        return PaymentMethodTile.sbp(selectedByDefault);
      case PaymentMethod.sberPay:
        return PaymentMethodTile.sberPay(selectedByDefault);
      // Способ оплаты терминалом объединён с оплатой наличными.
      default:
        return PaymentMethodTile.cash(selectedByDefault);
    }
  }

  /// Создаёт виджет для оплаты банковской картой.
  PaymentMethodTile.bankCard(this.selectedByDefault)
      : image = Assets.images.newCard,
        title = t.paymentMethods.bankCard,
        method = PaymentMethod.bankCard;

  /// Создаёт виджет для оплаты через СБП.
  PaymentMethodTile.sbp(this.selectedByDefault)
      : image = Assets.images.sbp,
        title = t.paymentMethods.sbp,
        method = PaymentMethod.sbp;

  /// Создаёт виджет для оплаты черезе SberPay.
  PaymentMethodTile.sberPay(this.selectedByDefault)
      : image = Assets.images.sberPay,
        method = PaymentMethod.sberPay,
        title = t.paymentMethods.sberPay;

  /// Создаёт виджет для оплаты наличными.
  PaymentMethodTile.cash(this.selectedByDefault)
      : image = Assets.images.ruble,
        title = t.paymentMethods.cash,
        method = PaymentMethod.cash;

  /// Иконка метода оплаты.
  final AssetGenImage image;

  /// Название метода оплаты.
  final String title;

  /// Метод оплаты.
  final PaymentMethod method;

  /// Признак, выбран ли метод оплаты по умолчанию.
  ///
  /// В таком случае отсутствует иконка выбора.
  final bool selectedByDefault;

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<PaymentMethodSelectionCubit>();
    final bool selected = cubit.state.method == method;

    return InkWell(
      onTap: () => selectedByDefault ? null : cubit.selectPaymentMethod(method),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.colors.mainColors.bgCard,
          borderRadius: AppBorders.kCircular12,
        ),
        child: Padding(
          padding: AppInsets.kAll12,
          child: Row(
            children: [
              image.image(
                height: AppSizes.kGeneral24,
                width: AppSizes.kGeneral32,
              ),
              AppBoxes.kWidth12,
              Text(
                title,
                style: context.textStyle.textTypo.tx1Medium,
              ),
              const Spacer(),
              if (selectedByDefault)
                const SizedBox.shrink()
              else if (selected)
                Assets.icons.check.svg(
                  height: AppSizes.kIconMedium,
                  width: AppSizes.kIconMedium,
                )
              else
                Assets.icons.unchecked.svg(
                  height: AppSizes.kIconMedium,
                  width: AppSizes.kIconMedium,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
