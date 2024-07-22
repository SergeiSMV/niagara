import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
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
  ) : super(const _Loading()) {
    on<_LoadingEvent>(_onLoadOrders, transformer: debounce());
    on<_LoadMoreEvent>(_onLoadMoreOrders, transformer: debounce());
    on<_SetSortEvent>(_onSortChanged);

    add(const _LoadingEvent(isForceUpdate: true));
  }

  final GetOrdersUseCase _getOrdersUseCase;

  int _current = 1;
  int _total = 0;
  bool get hasMore => _total > _current;

  OrdersTypes _sort = OrdersTypes.delivery;
  OrdersTypes get sort => _sort;

  Future<void> _onLoadOrders(_LoadingEvent event, _Emit emit) async {
    if (event.isForceUpdate) {
      emit(const _Loading());
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
          ),
        );
      },
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
}
