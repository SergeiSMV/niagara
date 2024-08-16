import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/features/order_placing/domain/models/tokenization_data.dart';
import 'package:niagara_app/features/payments/presentation/bloc/payments_cubit.dart';

@RoutePage()
class PaymentPage extends StatelessWidget {
  const PaymentPage({
    super.key,
    required this.tokenizationData,
    required this.successRoute,
    required this.errorRoute,
  });

  final TokenizationData tokenizationData;
  final PageRouteInfo successRoute;
  final PageRouteInfo errorRoute;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PaymentsCubit>()
        ..startTokenization(
          tokenizationData,
        ),
      child: Center(
        child: BlocConsumer<PaymentsCubit, PaymentsState>(
          listener: (context, state) => state.whenOrNull(
            success: () => context.replaceRoute(successRoute),
            orderCanceled: () => context.replaceRoute(errorRoute),
          ),
          builder: (context, state) => state.when(
            initial: () => const Text('Следуйте инструкциям на экране'),
            loading: AppCenterLoader.new,
            tokenizationError: () => const Text('Ошибка токенизации'),
            getConfirmationUrlError: () =>
                const Text('Ошибка получения ссылки на подтверждение'),
            confirmationError: () => const Text('Ошибка подтверждения'),
            paymentStatusError: () =>
                const Text('Ошибка получения статуса оплаты'),
            success: () => const Text('Оплата прошла успешно'),
            orderCanceled: () => const Text('Заказ отменен'),
          ),
        ),
      ),
    );
  }
}
