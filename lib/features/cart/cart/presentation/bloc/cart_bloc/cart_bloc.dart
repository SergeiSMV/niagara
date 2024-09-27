import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/cart_clear_types.dart';
import 'package:niagara_app/features/authorization/phone_auth/domain/use_cases/auth/has_auth_status_use_case.dart';
import 'package:niagara_app/features/cart/cart/domain/models/cart.dart';
import 'package:niagara_app/features/cart/cart/domain/use_cases/add_to_cart_use_case.dart';
import 'package:niagara_app/features/cart/cart/domain/use_cases/get_cart_use_case.dart';
import 'package:niagara_app/features/cart/cart/domain/use_cases/get_recommends_cart_use_case.dart';
import 'package:niagara_app/features/cart/cart/domain/use_cases/remove_all_from_cart_use_case.dart';
import 'package:niagara_app/features/cart/cart/domain/use_cases/remove_from_cart_use_case.dart';
import 'package:niagara_app/features/locations/addresses/domain/use_cases/address/get_default_address_use_case.dart';

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
    this._getRecommendsCartUseCase,
    this._getDefaultAddressUseCase,
    this._hasAuthStatusUseCase,
  ) : super(const _Empty()) {
    on<_GetCart>(_onGetCart);
    on<_AddToCart>(_onAddToCart);
    on<_RemoveFromCart>(_onRemoveFromCart);
    on<_RemoveAllFromCart>(_onRemoveAllFromCart);
    on<_SetReturnTareCount>(_onSetReturnTareCount);
    on<_SetBonusesToPay>(_onSetBonusesToPay);
    on<_ToggleAllTare>(_onToggleAllTare);
    on<_SetPromocode>(_onSetPromocode);

    add(const _GetCart());
  }

  final GetCartUseCase _getCartUseCase;
  final AddToCartUseCase _addToCartUseCase;
  final RemoveFromCartUseCase _removeFromCartUseCase;
  final RemoveAllFromCartUseCase _removeAllFromCartUseCase;
  final GetRecommendsCartUseCase _getRecommendsCartUseCase;
  final GetDefaultAddressUseCase _getDefaultAddressUseCase;
  final HasAuthStatusUseCase _hasAuthStatusUseCase;

  bool _returnAllTare = true;
  int _returnTaresDefault = 0;
  int _returnTareCount = 0;

  int _bonusesToPay = 0;
  String _promocode = '';

  Future<bool?> get _checkAuth => _hasAuthStatusUseCase.call().fold(
        (_) => null,
        (hasAuth) => hasAuth,
      );

  Future<void> _onGetCart(_GetCart event, _Emit emit) async {
    final (cart, recommends) = state.maybeWhen(
      loaded: (cart, recommends) => (cart, recommends),
      loading: (cart, recommends) => (cart, recommends),
      orElse: () => (null, null),
    );

    emit(_Loading(cart: cart, recommends: recommends));

    final bool? hasAuth = await _checkAuth;
    if (hasAuth == null) {
      return emit(const _Error());
    } else if (!hasAuth) {
      return emit(const _Unauthorized());
    }

    final locationId = await _getDefaultAddress();

    await _getCartUseCase
        .call(
      GetCartParams(
        locationId: locationId,
        bonuses: _bonusesToPay,
        promocode: _promocode,
        tareCount: _returnTareCount,
        allTare: _returnAllTare,
      ),
    )
        .fold(
      (_) => emit(const _Error()),
      (cart) async {
        if (cart.isEmpty) return emit(const _Empty());

        _returnTareCount = cart.cartData.tareCount;
        _returnTaresDefault = cart.cartData.totalTares;
        _returnAllTare = _returnTareCount == _returnTaresDefault;

        final recommends = await _getRecommendsCartUseCase.call().fold(
              (failure) => <Product>[],
              (products) => products,
            );

        emit(
          _Loaded(
            cart: cart,
            recommends: recommends,
          ),
        );
      },
    );
  }

  Future<void> _onAddToCart(
    _AddToCart event,
    _Emit emit,
  ) async =>
      await _addToCartUseCase(AddToCartParams(product: event.product)).fold(
        (_) => emit(const _Error()),
        (success) async =>
            success ? add(const _GetCart()) : emit(const _Error()),
      );

  Future<void> _onRemoveFromCart(
    _RemoveFromCart event,
    _Emit emit,
  ) async =>
      await _removeFromCartUseCase(
        RemoveFromCartParams(
          product: event.product,
          all: event.all ?? false,
        ),
      ).fold(
        (_) => emit(const _Error()),
        (success) async =>
            success ? add(const _GetCart()) : emit(const _Error()),
      );

  Future<void> _onRemoveAllFromCart(
    _RemoveAllFromCart event,
    _Emit emit,
  ) async =>
      await _removeAllFromCartUseCase(event.type).fold(
        (_) => emit(const _Error()),
        (success) async =>
            success ? add(const _GetCart()) : emit(const _Error()),
      );

  Future<String> _getDefaultAddress() async =>
      await _getDefaultAddressUseCase.call().fold(
            (failure) => '',
            (address) => address.locationId,
          );

  void _onSetReturnTareCount(
    _SetReturnTareCount event,
    _Emit emit,
  ) {
    if (_returnTareCount + event.count < 0) return;

    _returnTareCount += event.count;
    add(const _GetCart());
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
    } else {
      _returnTareCount = 0;
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
}
