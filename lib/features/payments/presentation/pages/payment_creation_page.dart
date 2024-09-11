import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/payment_methods/widgets/pay_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/payment_methods/widgets/payment_method_selection_widget.dart';
import 'package:niagara_app/core/utils/enums/payment_method_type.dart';
import 'package:niagara_app/features/order_placing/domain/models/tokenization_data.dart';

/// Страница оплаты.
///
/// Позволяет выбрать метод оплаты и оплатить заказ.
///
/// Отображает информацию о заказе [purchasedProductWidget], список методов
/// оплаты и кнопку оплаты.
@RoutePage()
class PaymentCreationPage extends StatelessWidget {
  const PaymentCreationPage({
    super.key,
    required this.pageTitle,
    required this.purchasedProductWidget,
    required this.onPaymentMethodChanged,
    required this.onSuccess,
    required this.onCancelled,
    required this.amountRub,
    required this.payButtonText,
    required this.onCreateOrder,
    this.productCount,
  });

  /// Заголовок страницы. Отображается в [AppBarWidget].
  final String pageTitle;

  /// Виджет-заголовок страницы, отображающий информацию о преобретаемом товаре.
  final Widget purchasedProductWidget;

  /// Коллбэк, вызываемый при изменении метода оплаты.
  final void Function(PaymentMethod? method) onPaymentMethodChanged;

  /// Коллбэк, вызываемый при успешном оформлении заказа.
  ///
  /// Используйте для изменения состояния навигации.
  final VoidCallback onSuccess;

  /// Коллбэк, вызываемый при отмене оформления заказа или ошибке.
  ///
  /// Используйте для изменения состояния навигации.
  final VoidCallback onCancelled;

  /// Коллбэк, вызываемый при нажатии на кнопку оплаты.
  ///
  /// Используйте для создания заказа. Должен возвращать [TokenizationData].
  final Future<TokenizationData> Function() onCreateOrder;

  /// Сумма покупки в рублях.
  final String amountRub;

  /// Текст кнопки оплаты.
  final String payButtonText;

  /// Количество товаров.
  ///
  /// Если указано, кнопка оплаты будет содержать текст "`n` товаров".
  final int? productCount;

  /// Обработчик нажатия на кнопку оплаты.
  Future<void> _onStartPayment(BuildContext context) async {
    // Создаем заказ и получаем данные для токенизации платежа.
    final TokenizationData tokenizationData = await onCreateOrder();

    if (!context.mounted) return;

    // Открываем страницу хода оплаты.
    context.pushRoute(
      PaymentInstructionsRoute(
        tokenizationData: tokenizationData,
        onSuccess: onSuccess,
        onCancelled: onCancelled,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBarWidget(title: pageTitle),
          SliverList(
            delegate: SliverChildListDelegate([
              purchasedProductWidget,
              PaymentMethodSelectionWidget(
                onValueChanged: onPaymentMethodChanged,
              ),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: PaymentButton(
        amountRub: amountRub,
        buttonText: payButtonText,
        productCount: productCount,
        onTap: () => _onStartPayment(context),
      ),
    );
  }
}
