import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/order_history/data/local/entities/user_order_entity.dart';
import 'package:niagara_app/features/order_history/data/mappers/user_entity_mapper.dart';

abstract interface class IOrdersLocalDatasource {
  Future<Either<Failure, List<UserOrderEntity>>> getAddresses();

  Future<Either<Failure, void>> saveOrders(List<UserOrderEntity> orders);

  Future<Either<Failure, void>> addOrders(UserOrderEntity order);

  Future<Either<Failure, void>> updateOrders(UserOrderEntity order);

  Future<Either<Failure, void>> deleteOrders(UserOrderEntity order);
}

@LazySingleton(as: IOrdersLocalDatasource)
class OrdersLocalDatasource implements IOrdersLocalDatasource {
  OrdersLocalDatasource(this._database);

  final AppDatabase _database;

  @override
  Future<Either<Failure, List<UserOrderEntity>>> getAddresses() => _execute(
        () async => (await _database.allOrders.getOrders())
            .map((table) => table.toEntity())
            .toList(),
      );

  @override
  Future<Either<Failure, void>> saveOrders(List<UserOrderEntity> orders) =>
      _execute(
        () => _database.allOrders.insertOrders(
          orders.map((entity) => entity.toCompanion()).toList(),
        ),
      );

  @override
  Future<Either<Failure, void>> addOrders(UserOrderEntity order) => _execute(
        () => _database.allOrders.insertOrder(order.toCompanion()),
      );

  @override
  Future<Either<Failure, void>> updateOrders(UserOrderEntity order) => _execute(
        () => _database.allOrders.updateOrder(order.toCompanion()),
      );

  @override
  Future<Either<Failure, void>> deleteOrders(UserOrderEntity order) => _execute(
        () => _database.allOrders.deleteOrder(order.toCompanion()),
      );

  Future<Either<Failure, T>> _execute<T>(Future<T> Function() action) async {
    try {
      final result = await action();
      return Right(result);
    } on Failure catch (e) {
      return Left(AddressesLocalDataFailure(e.toString()));
    }
  }
}
