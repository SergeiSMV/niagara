import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/payment_methods/payment_method_tile.dart';
import 'package:niagara_app/core/common/presentation/widgets/payment_methods/payment_method_type_item.dart';
import 'package:niagara_app/core/common/presentation/widgets/payment_methods/payment_methods_list_widget.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class PaymentMethodsSelectionWidget extends StatefulWidget {
  const PaymentMethodsSelectionWidget({super.key});

  @override
  State<PaymentMethodsSelectionWidget> createState() =>
      _PaymentMethodsSelectionWidgetState();
}

class _PaymentMethodsSelectionWidgetState
    extends State<PaymentMethodsSelectionWidget> {
  /// Индекс выбранной вкладки.
  ///
  /// `0` - оплата онлайн, `1` - оплата наличными.
  int _selectedTabIndex = 0;

  /// Индекс выбранного элемента.
  int? _selectedIndex;

  void _onPaymentTypeSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  void _onPaymentMethodSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            PaymentMethodTypeItem(
              title: t.orderPlacing.online,
              isSelected: _selectedTabIndex == 0,
              onTap: () => _onPaymentTypeSelected(0),
              icon: Assets.icons.add,
            ),
            PaymentMethodTypeItem(
              title: t.orderPlacing.byCourier,
              isSelected: _selectedTabIndex == 1,
              onTap: () => _onPaymentTypeSelected(1),
              icon: Assets.icons.ruble,
            ),
          ],
        ),
        if (_selectedTabIndex == 0)
          PaymentMethodsListWidget(
            children: [
              PaymentMethodTile(
                image: Assets.images.sbp,
                title: t.paymentMethods.sbp,
                selected: _selectedIndex == 0,
                onTap: () => _onPaymentMethodSelected(0),
              ),
              PaymentMethodTile(
                image: Assets.images.mir,
                title: t.paymentMethods.mir(lastDigits: '1760'),
                selected: _selectedIndex == 1,
                onTap: () => _onPaymentMethodSelected(1),
              ),
              PaymentMethodTile(
                image: Assets.images.sberPay,
                title: t.paymentMethods.sberPay,
                selected: _selectedIndex == 2,
                onTap: () => _onPaymentMethodSelected(2),
              ),
              PaymentMethodTile.addNewCard(onTap: () {}),
            ],
          )
        else
          Text(
            t.orderPlacing.paymentMethodDescription,
            style: context.textStyle.textTypo.tx2Medium,
          ),
      ],
    );
  }
}
