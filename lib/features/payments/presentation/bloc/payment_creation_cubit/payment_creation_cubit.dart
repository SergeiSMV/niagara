import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/order_type.dart';
import 'package:niagara_app/core/utils/enums/payment_method_type.dart';
import 'package:niagara_app/core/utils/enums/placing_order_error_type.dart';
import 'package:niagara_app/features/order_placing/domain/models/tokenization_data.dart';
import 'package:niagara_app/features/payments/presentation/pages/payment_creation_page.dart';
import 'package:niagara_app/features/prepaid_water/domain/model/prepaid_water_order_data.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/activation_option.dart';
import 'package:niagara_app/features/vip/domain/use_cases/order_vip_use_case.dart';

part 'payment_creation_state.dart';
part 'payment_creation_cubit.freezed.dart';

// TODO(kvbykov): Добавить пополнение баланса предоплатной воды.
// https://digitalburo.youtrack.cloud/issue/NIAGARA-305/Vstroit-modul-oplat-na-ekran-predoplatnoj-vody

// N.B: Этот кубит работает для ВИП-подписки и предоплатной воды.
// Обычное оформление заказа здесь не происходит, т.к. там совершенно по-другому
// работает логика экрана.

/// [Cubit] для создания заказа.
///
/// Используется для менеджмента состояния страницы создания заказа
/// [PaymentCreationPage].
@injectable
class PaymentCreationCubit extends Cubit<PaymentCreationState> {
  PaymentCreationCubit(
    @factoryParam this._activationOption,
    @factoryParam this._prepaidWaterData,
    this._orderVipUseCase,
  )   : assert(
          (_activationOption != null) ^ (_prepaidWaterData != null),
          'Один и только один из параметров для формирования заказа должен быть не `null`',
        ),
        super(const PaymentCreationState.initial());

  /// Выбранный метод оплаты.
  PaymentMethod? paymentMethod;

  /// Кейс создания заказа ВИП-подписки.
  final OrderVipUseCase _orderVipUseCase;

  /// Способ активации ВИП-подписки. Имеет смысл для [OrderType.vip].
  final ActivationOption? _activationOption;

  /// Информация для формирования заказа предоплатной воды.
  // ignore: unused_field, use_late_for_private_fields_and_variables
  final PrepaidWaterOrderData? _prepaidWaterData;

  /// Тип заказа.
  bool get _isVip => _activationOption != null;

  /// Создаёт заказ.
  Future<void> placeOrder() async {
    final bool isDataValid = _checkPaymentMethod();

    if (!isDataValid) return;

    emit(const PaymentCreationState.loading());

    if (_isVip) {
      await _orderVip();
    } else {
      await _orderPrepaidWater();
    }
  }

  /// Создаёт заказ ВИП-подписки.
  Future<void> _orderVip() async {
    final params = OrderVipParams(
      paymentMethod: paymentMethod!,
      activationOption: _activationOption!,
    );

    await _orderVipUseCase(params).fold(
      (failure) {
        late final OrderPlacingErrorType errorType;

        if (failure is NoInternetFailure) {
          errorType = OrderPlacingErrorType.noInternet;
        } else {
          errorType = OrderPlacingErrorType.unknown;
        }

        emit(PaymentCreationState.error(type: errorType));
      },
      (data) => emit(PaymentCreationState.created(data: data)),
    );
  }

  /// Создаёт заказ предоплатной воды.
  Future<void> _orderPrepaidWater() async {
    emit(
      const PaymentCreationState.error(type: OrderPlacingErrorType.unknown),
    );
  }

  /// Проверяет, выбран ли метод оплаты и валидирует его.
  bool _checkPaymentMethod() {
    final bool selected = paymentMethod != null;
    final bool isValid = selected && paymentMethod!.isOnline;

    if (!selected) {
      emit(
        const PaymentCreationState.error(
          type: OrderPlacingErrorType.noPaymentMethod,
        ),
      );
    } else if (!isValid) {
      // Предоплатная вода и ВИП оплачиваются только онлайн.
      emit(
        const PaymentCreationState.error(
          type: OrderPlacingErrorType.unsupportedPaymentMethod,
        ),
      );
    }

    return isValid;
  }
}
