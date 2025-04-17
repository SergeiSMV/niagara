import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../core/common/domain/models/product.dart';
import '../../../../../../core/core.dart';
import '../../../../../../core/utils/constants/app_constants.dart';
import '../../../../../../core/utils/enums/auth_status.dart';
import '../../../../../../core/utils/enums/cart_clear_types.dart';
import '../../../../../authorization/phone_auth/domain/use_cases/auth/has_auth_status_use_case.dart';
import '../../../../../locations/addresses/domain/use_cases/address/get_default_address_use_case.dart';
import '../../../domain/models/cart.dart';
import '../../../domain/use_cases/add_to_cart_use_case.dart';
import '../../../domain/use_cases/cart_params.dart';
import '../../../domain/use_cases/get_cart_use_case.dart';
import '../../../domain/use_cases/remove_all_from_cart_use_case.dart';
import '../../../domain/use_cases/remove_from_cart_use_case.dart';

part 'cart_bloc.freezed.dart';
part 'cart_event.dart';
part 'cart_state.dart';

typedef _Emit = Emitter<CartState>;

/// [Bloc] для работы с корзиной.
@lazySingleton
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(
    this._getCartUseCase,
    this._addToCartUseCase,
    this._removeFromCartUseCase,
    this._removeAllFromCartUseCase,
    this._getDefaultAddressUseCase,
    this._hasAuthStatusUseCase,
    this._authStatusStream,
  ) : super(const _Empty()) {
    _authStatusSubscription = _authStatusStream.listen(_onAuthStatusChanged);

    on<_GetCart>(_onGetCart);
    on<_AddToCart>(_onAddToCart);
    on<_RemoveFromCart>(_onRemoveFromCart);
    on<_RemoveAllFromCart>(_onRemoveAllFromCart);
    on<_SetReturnTareCount>(_onSetReturnTareCount);
    on<_SetOtherReturnTareCount>(_onSetOtherReturnTareCount);
    on<_CancelAllTare>(_onCancelAllTare);
    on<_SetBonusesToPay>(_onSetBonusesToPay);
    on<_ToggleAllTare>(_onToggleAllTare);
    on<_ToggleAllOtherTare>(_onToggleAllOtherTare);
    on<_SetPromocode>(_onSetPromocode);
    on<_LoggedOut>(_onLoggedOut);

    add(const _GetCart());
  }

  final GetCartUseCase _getCartUseCase;
  final AddToCartUseCase _addToCartUseCase;
  final RemoveFromCartUseCase _removeFromCartUseCase;
  final RemoveAllFromCartUseCase _removeAllFromCartUseCase;
  final GetDefaultAddressUseCase _getDefaultAddressUseCase;
  final HasAuthStatusUseCase _hasAuthStatusUseCase;
  final Stream<AuthenticatedStatus> _authStatusStream;

  bool _returnAllTare = true;
  bool _returnAllOtherTare = false;
  int _returnTaresDefault = 0;
  int _returnTareCount = 0;
  int _otherReturnTareCount = 0;

  int _bonusesToPay = 0;
  String _promocode = '';

  final Map<String, int> _pendingProducts = {};

  Set<String> get _pendingHash => {..._pendingProducts.keys};

  bool pendingClear = false;

  bool isPendingProduct(Product product) =>
      (_pendingProducts[product.pendingId] ?? 0) > 0;

  bool get unauthrorized => state.maybeWhen(
        unauthorized: () => true,
        orElse: () => false,
      );

  Future<CartParams> get _params async => CartParams(
        allTare: _returnAllTare,
        bonuses: _bonusesToPay,
        promocode: _promocode,
        tareCount: _returnTareCount,
        otherTareCount: _otherReturnTareCount,
        locationId: await _getDefaultAddress(),
      );

  StreamSubscription? _authStatusSubscription;

  Future<bool?> get _hasAuth => _hasAuthStatusUseCase.call().fold(
        (_) => null,
        (hasAuth) => hasAuth,
      );

  /// Проверяет, есть ли товар в корзине в разделе "Недоступно к заказу".
  bool isOutOfStock(Product product) => state.maybeWhen(
        orElse: () => false,
        loaded: (cart, _) {
          final productInCart = cart.unavailableProducts.firstWhereOrNull(
            (element) => element.id == product.id,
          );
          return productInCart != null;
        },
        loading: (cart, _, __) {
          final productInCart = cart?.unavailableProducts.firstWhereOrNull(
            (element) => element.id == product.id,
          );
          return productInCart != null;
        },
      );

  /// Когда изменяется состояние авторизации, происходит новый запрос корзины.
  void _onAuthStatusChanged(AuthenticatedStatus status) =>
      status.hasAuth ? add(const _GetCart()) : add(const _LoggedOut());

  /// При выходе из аккаунта сразу же испускается состание [_Unauthorized].
  void _onLoggedOut(_LoggedOut event, _Emit emit) =>
      emit(const _Unauthorized());

  /// Обработчик событий, которые требуют проверки авторизации.
  ///
  /// Также испускает состояние загрузки.
  Future<bool> _handleEvent(_Emit emit) async {
    final (cart, recommends) = state.maybeWhen(
      loaded: (cart, recommends) => (cart, recommends),
      loading: (cart, recommends, _) => (cart, recommends),
      orElse: () => (null, null),
    );

    emit(
      _Loading(
        cart: cart,
        recommends: recommends,
        pendingProducts: _pendingHash,
      ),
    );

    final bool? hasAuth = await _hasAuth;
    if (hasAuth == null) {
      emit(const _Error());
      return false;
    } else if (!hasAuth) {
      emit(const _Unauthorized());
      return false;
    }

    return true;
  }

  /// Обновляет значения параметров [CartParams], которые используются при
  /// запросе получения или изменения состояния корзины.
  void _updateCartParams(Cart cart) {
    _returnTareCount = cart.cartData.tareCount;
    _returnTaresDefault = cart.cartData.totalTares;
    _returnAllTare = _returnTareCount == _returnTaresDefault;
  }

  Future<void> _onGetCart(_GetCart event, _Emit emit) async {
    if (!await _handleEvent(emit)) return;

    final String locationId = await _getDefaultAddress();
    await _getCartUseCase
        .call(
      GetCartParams(
        locationId: locationId,
        bonuses: _bonusesToPay,
        promocode: _promocode,
        tareCount: _returnTareCount,
        otherTareCount: _otherReturnTareCount,
        allTare: _returnAllTare,
      ),
    )
        .fold(
      (_) => emit(const _Error()),
      (cart) async {
        _updateCartParams(cart);

        emit(
          cart.isEmpty
              ? const _Empty()
              : _Loaded(
                  cart: cart,
                  recommends: cart.recommends,
                ),
        );
      },
    );
  }

  Future<void> _onAddToCart(
    _AddToCart event,
    _Emit emit,
  ) async {
    _pendingProducts.update(
      event.product.pendingId,
      (value) => value + 1,
      ifAbsent: () => 1,
    );

    if (!await _handleEvent(emit)) return;

    final result = await _addToCartUseCase(
      AddToCartParams(
        product: event.product,
        withdrawingWater: event.prepaidWater ?? false,
        cartParams: await _params,
      ),
    );

    _pendingProducts.update(event.product.pendingId, (value) => value - 1);

    result.fold(
      (_) => emit(const _Error()),
      (cart) {
        _updateCartParams(cart);

        emit(
          cart.isEmpty
              ? const _Empty()
              : _Loaded(
                  cart: cart,
                  recommends: cart.recommends,
                ),
        );
      },
    );
  }

  Future<void> _onRemoveFromCart(
    _RemoveFromCart event,
    _Emit emit,
  ) async {
    _pendingProducts.update(
      event.product.pendingId,
      (value) => value + 1,
      ifAbsent: () => 1,
    );

    if (!await _handleEvent(emit)) return;

    final result = await _removeFromCartUseCase(
      RemoveFromCartParams(
        product: event.product,
        withdrawingWater: event.prepaidWater ?? false,
        all: event.all ?? false,
        cartParams: await _params,
      ),
    );

    _pendingProducts.update(event.product.pendingId, (value) => value - 1);

    result.fold(
      (_) => emit(const _Error()),
      (cart) async {
        /// Если корзина пустая, то обнуляем бонусы к оплате для корректного
        /// отображения и пересчета
        if (cart.isEmpty) {
          add(const _SetBonusesToPay(bonuses: AppConstants.kZeroBonusesToPay));
        }
        emit(
          cart.isEmpty
              ? const _Empty()
              : _Loaded(
                  cart: cart,
                  recommends: cart.recommends,
                ),
        );
      },
    );
  }

  /// Удаляет все товары из корзины.
  Future<void> _onRemoveAllFromCart(
    _RemoveAllFromCart event,
    _Emit emit,
  ) async {
    if (!await _handleEvent(emit)) return;
    emit(const _Empty());

    /// Обнуляем счетчики тары к возврату
    add(const _CancelAllTare());

    final result = await _removeAllFromCartUseCase(
      RemoveAllFromCartParams(
        type: event.type,
        cartParams: await _params,
      ),
    );

    result.fold(
      (_) => emit(const _Error()),
      (cart) {
        /// Обнуляем бонусы к оплате для корректного отображения и пересчета
        add(const _SetBonusesToPay(bonuses: AppConstants.kZeroBonusesToPay));
        emit(
          cart.isEmpty
              ? const _Empty()
              : _Loaded(
                  cart: cart,
                  recommends: cart.recommends,
                ),
        );
      },
    );
  }

  Future<String> _getDefaultAddress() async =>
      await _getDefaultAddressUseCase.call().fold(
            (failure) => '',
            (address) => address?.locationId ?? '',
          );

  void _onSetReturnTareCount(
    _SetReturnTareCount event,
    _Emit emit,
  ) {
    if (event.count < 0) {
      _returnAllOtherTare = false;
      _returnAllTare = false;
    }

    final advanceResult =
        _otherReturnTareCount + _returnTareCount + event.count;

    if (advanceResult > _returnTaresDefault) {
      if (_otherReturnTareCount > 0) {
        _otherReturnTareCount -= event.count;
        _returnAllOtherTare = false;
      } else {
        return;
      }
    }
    if (_returnTareCount + event.count < 0) return;

    _returnTareCount += event.count;
    add(const _GetCart());
  }

  void _onSetOtherReturnTareCount(
    _SetOtherReturnTareCount event,
    _Emit emit,
  ) {
    if (event.count < 0) {
      _returnAllOtherTare = false;
      _returnAllTare = false;
    }

    /// Превдарительный результат, который получается при сложении всех
    /// тар к возврату
    final advanceResult =
        _otherReturnTareCount + _returnTareCount + event.count;

    /// Если ввышло больше, чем можно, уменьшаем основные тары (если они есть)
    if (advanceResult > _returnTaresDefault) {
      if (_returnTareCount > 0) {
        _returnTareCount -= event.count;
        _returnAllTare = false;
      } else {
        return;
      }
    }

    // Если вышло меньше, тут ничего не поделать
    if (_otherReturnTareCount + event.count < 0) return;

    _otherReturnTareCount += event.count;
    add(const _GetCart());
  }

  /// Обнуляет все тары к возврату
  void _onCancelAllTare(_CancelAllTare event, _Emit emit) {
    _returnTareCount = 0;
    _otherReturnTareCount = 0;
  }

  void _onSetBonusesToPay(
    _SetBonusesToPay event,
    _Emit emit,
  ) {
    _bonusesToPay = event.bonuses;
    add(const _GetCart());
  }

  void _onToggleAllTare(
    _ToggleAllTare event,
    _Emit emit,
  ) {
    _returnAllTare = !_returnAllTare;

    if (_returnAllTare) {
      _returnTareCount = _returnTaresDefault;
      _returnAllOtherTare = false;
      _otherReturnTareCount = 0;
    } else {
      _returnTareCount = 0;
    }

    add(const _GetCart());
  }

  void _onToggleAllOtherTare(
    _ToggleAllOtherTare event,
    _Emit emit,
  ) {
    _returnAllOtherTare = !_returnAllOtherTare;

    if (_returnAllOtherTare) {
      _otherReturnTareCount = _returnTaresDefault;
      _returnAllTare = false;
      _returnTareCount = 0;
    } else {
      _otherReturnTareCount = 0;
    }

    add(const _GetCart());
  }

  void _onSetPromocode(
    _SetPromocode event,
    _Emit emit,
  ) {
    _promocode = event.promocode;
    add(const _GetCart());
  }

  @override
  Future<void> close() {
    _authStatusSubscription?.cancel();
    return super.close();
  }
}
