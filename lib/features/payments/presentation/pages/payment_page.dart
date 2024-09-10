import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/common/presentation/widgets/snack_bars/app_snack_bar.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/order_placing/domain/models/tokenization_data.dart';
import 'package:niagara_app/features/payments/presentation/bloc/payments_cubit.dart';

/// Экран с информацией о ходе оплаты.
@RoutePage()
class PaymentPage extends StatelessWidget {
  const PaymentPage({
    super.key,
    required this.tokenizationData,
    required this.onSuccess,
    required this.onCancelled,
  });

  /// Данные для токенизации платежа.
  final TokenizationData tokenizationData;

  /// Коллбек, вызываемый в случае успешного завершения платежа.
  final VoidCallback onSuccess;

  /// Коллбек, вызываемый в случае ошибки платежа.
  final VoidCallback onCancelled;

  /// Обработчик состояния оплаты.
  ///
  /// В случае успешной оплаты перенаправляет на [successRoute]. При отмене
  /// заказа или критичной ошибке перенаправляет на [errorRoute].
  ///
  /// При возникновении ошибки, требующей уведомления пользователя, отображает
  /// [AppSnackBar.showErrorShackBar] с текстом ошибки.
  void _orderStateListener(BuildContext context, PaymentsState state) =>
      state.whenOrNull(
        success: onSuccess,
        orderCanceled: onCancelled,
        error: (err) => AppSnackBar.showErrorShackBar(
          context,
          title: err.toErrorText,
          subtitle: err.toErrorDescription,
        ),
      );

  /// Повторно запускает процесс оплаты.
  void _onRetry(BuildContext context) {
    context.read<PaymentsCubit>().startPayment(tokenizationData);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PaymentsCubit>()..startPayment(tokenizationData),
      child: BlocConsumer<PaymentsCubit, PaymentsState>(
        listener: _orderStateListener,
        builder: (context, state) => state.maybeWhen(
          loading: AppCenterLoader.new,
          orElse: () => _Content(() => _onRetry(context)),
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content(this.onRetry);

  /// Обработчик повторной попытки оплаты.
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<PaymentsCubit>();
    final bool hasError = cubit.state.maybeMap(
      error: (value) => true,
      orElse: () => false,
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Assets.images.yookassaLogo.image(
              width: AppSizes.kYookassaLogoWidth,
              height: AppSizes.kYookassaLogoHeight,
            ),
            AppBoxes.kHeight16,
            Text(
              textAlign: TextAlign.center,
              t.orderPlacing.followInstructions,
              style: context.textStyle.headingTypo.h3,
            ),
          ],
        ),
      ),
      bottomNavigationBar: hasError
          ? Padding(
              padding: AppInsets.kHorizontal16 + AppInsets.kVertical12,
              child: AppTextButton.primary(
                text: t.orderPlacing.retry,
                onTap: onRetry,
              ),
            )
          : null,
    );
  }
}
