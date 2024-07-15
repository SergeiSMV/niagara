import 'package:niagara_app/core/common/data/mappers/pagination_mapper.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/orders_types.dart';
import 'package:niagara_app/features/order_history/data/mappers/user_order_mapper.dart';
import 'package:niagara_app/features/order_history/data/remote/data_source/orders_remote_datasource.dart';
import 'package:niagara_app/features/order_history/domain/repositories/orders_repository.dart';

@LazySingleton(as: IOrdersRepositories)
class OrdersRepositories extends BaseRepository implements IOrdersRepositories {
  OrdersRepositories(
    super._logger,
    this._ordersRDS,
  );

  final IOrdersRemoteDatasource _ordersRDS;

  @override
  Failure get failure => const OrdersRepositoryFailure();

  @override
  Future<Either<Failure, Orders>> getOrders({
    required int page,
    required OrdersTypes sort,
  }) =>
      execute(() async {
        return _ordersRDS
            .getOrders(
              page: page,
              sort: sort,
            )
            .fold(
              (failure) => throw failure,
              (dto) => (
                orders: dto.orders.map((e) => e.toModel()).toList(),
                pagination: dto.pagination.toModel(),
              ),
            );
      });
}
