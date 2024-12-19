import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/auth_status.dart';
import 'package:niagara_app/core/utils/enums/orders_types.dart';
import 'package:niagara_app/core/utils/extensions/flutter_bloc_ext.dart';
import 'package:niagara_app/features/order_history/domain/models/user_order.dart';
import 'package:niagara_app/features/order_history/domain/use_cases/get_orders_use_case.dart';

part 'orders_bloc.freezed.dart';
part 'orders_event.dart';
part 'orders_state.dart';

typedef _Emit = Emitter<OrdersState>;

@lazySingleton
class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc(
    this._getOrdersUseCase,
    this._authStatusStream,
  ) : super(const _Loading()) {
    _authStatusSubscription = _authStatusStream.listen(_onAuthStatusChanged);

    on<_LoadingEvent>(_onLoadOrders, transformer: debounce());
    on<_LoadMoreEvent>(_onLoadMoreOrders, transformer: debounce());
    on<_SetSortEvent>(_onSortChanged);
    on<_LoadAllEvent>(_onLoadAllOrders);

    add(const _LoadAllEvent());
    add(const _LoadingEvent(isForceUpdate: true));
  }

  final GetOrdersUseCase _getOrdersUseCase;
  final Stream<AuthenticatedStatus> _authStatusStream;

  /// Подписка на изменение статуса авторизации.
  StreamSubscription? _authStatusSubscription;

  int _current = 1;
  int _total = 0;
  bool get hasMore => _total > _current;

  OrdersTypes _sort = OrdersTypes.delivery;
  OrdersTypes get sort => _sort;

  /// Список заказов, который будет отображаться на главной странице.
  List<UserOrder>? _previewOrders;

  /// Когда изменяется состояние авторизации, происходит новый запрос списка
  /// заказов.
  void _onAuthStatusChanged(AuthenticatedStatus status) {
    _previewOrders = null;
    add(const _LoadAllEvent());
    add(const _LoadingEvent(isForceUpdate: true));
  }

  Future<void> _onLoadOrders(_LoadingEvent event, _Emit emit) async {
    if (event.isForceUpdate) {
      emit(_Loading(preview: _previewOrders));
      _current = 0;
    }

    final orders = state.maybeMap(
      loaded: (state) => state.orders,
      orElse: () => const <UserOrder>[],
    );

    _current++;

    await _getOrdersUseCase(
      OrdersParams(
        page: _current,
        sort: _sort,
      ),
    ).fold(
      (failure) => emit(const _Error()),
      (data) {
        _current = data.pagination.current;
        _total = data.pagination.total;

        emit(
          _Loaded(
            orders:
                event.isForceUpdate ? data.orders : [...orders, ...data.orders],
            preview: _previewOrders,
          ),
        );
      },
    );
  }

  /// Загружает вообще все заказы и отбирает оттуда заказы для превью на
  /// главной.
  Future<void> _onLoadAllOrders(_LoadAllEvent event, _Emit emit) async {
    await _getOrdersUseCase(
      const OrdersParams(page: 1),
    ).fold(
      (failure) => emit(const _Error()),
      (data) =>
          _previewOrders = data.orders.whereNot((o) => o.isCanceled).toList(),
    );

    state.mapOrNull(
      loaded: (state) => emit(
        _Loaded(
          orders: state.orders,
          preview: _previewOrders,
        ),
      ),
      loading: (state) => emit(
        _Loading(
          preview: _previewOrders,
        ),
      ),
    );
  }

  Future<void> _onLoadMoreOrders(_LoadMoreEvent event, _Emit emit) async {
    if (state is _Loading) return;
    if (hasMore) {
      add(const _LoadingEvent(isForceUpdate: false));
    }
  }

  Future<void> _onSortChanged(
    _SetSortEvent event,
    _Emit emit,
  ) async {
    _sort = event.sort;
    add(const _LoadingEvent(isForceUpdate: true));
  }

  @override
  Future<void> close() {
    _authStatusSubscription?.cancel();
    return super.close();
  }
}
