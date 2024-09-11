import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/payment_methods/widgets/pay_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/payment_methods/widgets/payment_method_selection_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/snack_bars/app_snack_bar.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/features/payments/presentation/bloc/payment_creation_cubit/payment_creation_cubit.dart';

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
    required this.onSuccess,
    required this.onCancelled,
    required this.amountRub,
    required this.payButtonText,
    this.productCount,
  });

  /// Заголовок страницы. Отображается в [AppBarWidget].
  final String pageTitle;

  /// Виджет-заголовок страницы, отображающий информацию о преобретаемом товаре.
  final Widget purchasedProductWidget;

  /// Коллбэк, вызываемый при успешном оформлении заказа.
  ///
  /// Используйте для изменения состояния навигации и запросов на получение
  /// обновлённых данных (состояние корзины, подписки т.д.).
  final VoidCallback onSuccess;

  /// Коллбэк, вызываемый при отмене оформления заказа или ошибке.
  ///
  /// Используйте для изменения состояния навигации.
  final VoidCallback onCancelled;

  /// Сумма покупки в рублях.
  final String amountRub;

  /// Текст кнопки оплаты.
  final String payButtonText;

  /// Количество товаров.
  ///
  /// Если указано, кнопка оплаты будет содержать текст "`n` товаров".
  final int? productCount;

  /// Оборачивает виджет в отступы.
  Widget _wrapPadding(Widget child) => Padding(
        padding: AppInsets.kHorizontal16,
        child: child,
      );

  /// Обработчик состояния оформления заказа.
  ///
  /// В случае ошибки отображает сообщение об ошибке.
  ///
  /// В случае успешного оформления заказа перенаправляет на страницу результата.
  void _paymentStateListener(
    BuildContext context,
    PaymentCreationState state,
  ) =>
      state.mapOrNull(
        // TODO: Добавить отображение номера телефона при ошибке "нет интернета"
        // https://digitalburo.youtrack.cloud/issue/NIAGARA-341/Dobavit-nomer-telefona-v-plashku-Net-interneta
        error: (err) => AppSnackBar.showErrorShackBar(
          context,
          title: err.type.toErrorTitle,
        ),
        created: (state) => context.pushRoute(
          // Перенаправляем на страницу оплаты.
          PaymentInstructionsRoute(
            tokenizationData: state.data,
            onSuccess: onSuccess,
            onCancelled: onCancelled,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<PaymentCreationCubit, PaymentCreationState>(
        listener: _paymentStateListener,
        child: CustomScrollView(
          slivers: [
            SliverAppBarWidget(title: pageTitle),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  AppBoxes.kHeight12,
                  purchasedProductWidget,
                  AppBoxes.kHeight24,
                  PaymentMethodSelectionWidget(
                    onValueChanged: (method) {
                      context.read<PaymentCreationCubit>().paymentMethod =
                          method;
                    },
                  ),
                ].map(_wrapPadding).toList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: PaymentButton(
        amountRub: amountRub,
        buttonText: payButtonText,
        productCount: productCount,
        onTap: () => context.read<PaymentCreationCubit>().placeOrder(),
      ),
    );
  }
}
