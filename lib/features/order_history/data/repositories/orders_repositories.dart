import 'package:niagara_app/core/common/data/mappers/pagination_mapper.dart';
import 'package:niagara_app/core/common/domain/models/pagination.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/order_status.dart';
import 'package:niagara_app/core/utils/enums/orders_types.dart';
import 'package:niagara_app/features/order_history/data/local/data_source/orders_local_data_source.dart';
import 'package:niagara_app/features/order_history/data/mappers/order_evaluation_option_mapper.dart';
import 'package:niagara_app/features/order_history/data/mappers/receipt_mapper.dart';
import 'package:niagara_app/features/order_history/data/mappers/user_entity_mapper.dart';
import 'package:niagara_app/features/order_history/data/mappers/user_order_mapper.dart';
import 'package:niagara_app/features/order_history/data/remote/data_source/orders_remote_datasource.dart';
import 'package:niagara_app/features/order_history/domain/models/order_rate_option.dart';
import 'package:niagara_app/features/order_history/domain/models/order_receipt.dart';
import 'package:niagara_app/features/order_history/domain/models/user_order.dart';
import 'package:niagara_app/features/order_history/domain/repositories/orders_repository.dart';

@LazySingleton(as: IOrdersRepository)
class OrdersRepositories extends BaseRepository implements IOrdersRepository {
  OrdersRepositories(
    super._logger,
    super._networkInfo,
    this._ordersRDS,
    this._ordersLDS,
  );

  final IOrdersRemoteDatasource _ordersRDS;
  final IOrdersLocalDatasource _ordersLDS;

  // TODO(kvbykov): Возможно, будет лучше сохрнаить чеки в БД.
  /// Кеш для чеков.
  final Map<String, OrderReceipt> _receipts = {};

  @override
  Failure get failure => const OrdersRepositoryFailure();

  @override
  Future<Either<Failure, Orders>> getOrders({
    required int page,
    required OrdersTypes sort,
  }) =>
      execute(
        () async => await _ordersRDS
            .getOrders(
          page: page,
          sort: sort,
        )
            .fold(
          (failure) async => await _getOrdersIfNoInternet(sort),
          (dto) async {
            final orders = (
              orders: dto.orders.map((e) => e.toModel()).toList(),
              pagination: dto.pagination.toModel(),
            );
            await _saveOrders(orders.orders);
            return orders;
          },
        ),
      );

  Future<List<UserOrder>> _getLocalOrders() async =>
      await _ordersLDS.getOrders().fold(
            (failure) => throw failure,
            (entities) => entities.map((entity) => entity.toModel()).toList(),
          );

  Future<Orders> _getOrdersIfNoInternet(OrdersTypes sort) async {
    final localOrders = await _getLocalOrders();
    final List<UserOrder> sortedLocalOrders = [];
    for (final item in localOrders) {
      bool shouldAdd = false;

      switch (sort) {
        case OrdersTypes.delivery:
          shouldAdd = item.orderStatus == OrderStatus.goingTo ||
              item.orderStatus == OrderStatus.onWay;
        case OrdersTypes.cancel:
          shouldAdd = item.orderStatus == OrderStatus.cancelled;
        case OrdersTypes.finish:
          shouldAdd = item.orderStatus == OrderStatus.received;
      }

      if (shouldAdd) sortedLocalOrders.add(item);
    }

    return (
      orders: sortedLocalOrders,
      pagination: const Pagination(items: 1, current: 1, total: 1),
    );
  }

  Future<void> _saveOrders(List<UserOrder> orders) async {
    final localOrders = await _getLocalOrders();
    for (final item in orders) {
      if (localOrders.any((localItem) => localItem.id == item.id)) {
        _ordersLDS.updateOrder(item.toEntity());
      } else {
        _ordersLDS.saveOrder(item.toEntity());
      }
    }
  }

  @override
  Future<Either<Failure, List<OrderRateOption>>> getOrderRateOptions({
    required int rating,
  }) =>
      execute(
        () async => _ordersRDS.getOrderRateOptions(rating: rating).fold(
              (failure) => throw failure,
              (dto) => dto.map((e) => e.toModel()).toList(),
            ),
      );

  @override
  Future<Either<Failure, bool>> rateOrder({
    required String id,
    required int rating,
    required String comment,
    required List<String> optionsIds,
  }) =>
      execute(
        () async => _ordersRDS
            .rateOrder(
              id: id,
              rating: rating,
              comment: comment,
              optionsIds: optionsIds,
            )
            .fold(
              (failure) => throw failure,
              (result) => result,
            ),
      );

  @override
  Future<Either<Failure, OrderReceipt>> getReceipt({required String id}) =>
      execute(
        () async {
          final OrderReceipt? cached = _receipts[id];
          if (cached != null) return cached;

          final OrderReceipt remote =
              await _ordersRDS.getOrderReceipt(id: id).fold(
                    (failure) => throw failure,
                    (dto) => dto.toModel(),
                  );

          _receipts[id] = remote;
          return remote;
        },
      );

  @override
  Future<Either<Failure, bool>> cancelOrder({required String id}) => execute(
        () async => _ordersRDS.cancelOrder(id: id).fold(
              (failure) => throw failure,
              (result) => result,
            ),
      );

  @override
  Future<Either<Failure, bool>> repeatOrder({required String id}) => execute(
        () async => _ordersRDS.repeatOrder(id: id).fold(
              (failure) => throw failure,
              (result) => result,
            ),
      );
}
