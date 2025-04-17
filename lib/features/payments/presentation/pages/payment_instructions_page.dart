import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/presentation/router/app_router.gr.dart';
import '../../../../core/common/presentation/widgets/app_bar.dart';
import '../../../../core/common/presentation/widgets/buttons/app_text_button.dart';
import '../../../../core/common/presentation/widgets/loaders/app_center_loader.dart';
import '../../../../core/common/presentation/widgets/snack_bars/app_snack_bar.dart';
import '../../../../core/dependencies/di.dart';
import '../../../../core/utils/constants/app_boxes.dart';
import '../../../../core/utils/constants/app_insets.dart';
import '../../../../core/utils/constants/app_sizes.dart';
import '../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../core/utils/gen/assets.gen.dart';
import '../../../../core/utils/gen/strings.g.dart';
import '../../../../core/utils/services/userx_service/userx_service.dart';
import '../../../order_placing/domain/models/tokenization_data.dart';
import '../bloc/payment_instructions_cubit/payment_instructions_cubit.dart';

/// Экран с информацией о ходе оплаты.
///
/// Отображает логотип Юкассы и текст с инструкциями по оплате.
///
/// При возникновении ошибок уведомляет пользователя с помощью снекбаров с
/// сообщениями.
///
/// После завершения оплаты вызывает [onSuccess] или [onCancelled] в зависимости
/// от результата обработки платежа.
@RoutePage()
class PaymentInstructionsPage extends StatefulWidget {
  const PaymentInstructionsPage({
    super.key,
    required this.tokenizationData,
    required this.onSuccess,
    required this.onCancelled,
  });

  /// Данные для токенизации платежа.
  final TokenizationData tokenizationData;

  /// Коллбек, вызываемый в случае успешного завершения платежа.
  ///
  /// Используйте для запросов на получение бновлённых данных (состояние
  /// корзины, подписки т.д.).
  final VoidCallback onSuccess;

  /// Коллбек, вызываемый в случае ошибки платежа.
  final VoidCallback onCancelled;

  @override
  State<PaymentInstructionsPage> createState() =>
      _PaymentInstructionsPageState();
}

class _PaymentInstructionsPageState extends State<PaymentInstructionsPage> {
  @override
  void initState() {
    super.initState();
    getIt<UserXService>().applyOcclusion();
  }

  @override
  void dispose() {
    getIt<UserXService>().removeOcclusion();
    super.dispose();
  }

  /// Обработчик состояния оплаты.
  ///
  /// В случае успешной оплаты перенаправляет на [successRoute]. При отмене
  /// заказа или критичной ошибке перенаправляет на [errorRoute].
  ///
  /// При возникновении ошибки, требующей уведомления пользователя, отображает
  /// [AppSnackBar.showError] с текстом ошибки.
  void _paymentStateListener(
    BuildContext context,
    PaymentInstructionsState state,
  ) =>
      state.whenOrNull(
        success: () {
          context.replaceRoute(OrderResultRoute(isSuccessful: true));
          return widget.onSuccess();
        },
        orderCanceled: () {
          context.replaceRoute(OrderResultRoute(isSuccessful: false));
          return widget.onCancelled();
        },
        error: (err) => AppSnackBar.showError(
          context,
          title: err.toErrorText,
          subtitle: err.toErrorDescription,
        ),
      );

  /// Повторно запускает процесс оплаты.
  Future<void> _onRetry(BuildContext context) async {
    context
        .read<PaymentInstructionsCubit>()
        .startPayment(widget.tokenizationData);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const AppBarWidget(),
        body: BlocProvider(
          create: (_) => getIt<PaymentInstructionsCubit>()
            ..startPayment(widget.tokenizationData),
          child:
              BlocConsumer<PaymentInstructionsCubit, PaymentInstructionsState>(
            listener: _paymentStateListener,
            builder: (context, state) => state.maybeWhen(
              loading: AppCenterLoader.new,
              orElse: () => _Content(() => _onRetry(context)),
            ),
          ),
        ),
      );
}

class _Content extends StatelessWidget {
  const _Content(this.onRetry);

  /// Обработчик повторной попытки оплаты.
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<PaymentInstructionsCubit>();
    final bool hasError = cubit.state.maybeMap(
      error: (value) => true,
      orElse: () => false,
    );
    final bool loading = cubit.state.maybeMap(
      loading: (_) => true,
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
                text: loading ? null : t.orderPlacing.retry,
                onTap: loading ? null : onRetry,
              ),
            )
          : null,
    );
  }
}
