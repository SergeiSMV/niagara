import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/orders_types.dart';
import 'package:niagara_app/features/order_history/domain/repositories/orders_repository.dart';

@injectable
class GetOrdersUseCase extends BaseUseCase<Orders, OrdersParams> {
  const GetOrdersUseCase(this._ordersRepository);

  final IOrdersRepository _ordersRepository;

  @override
  Future<Either<Failure, Orders>> call(OrdersParams params) async =>
      _ordersRepository.getOrders(
        page: params.page,
        sort: params.sort,
      );
}

class OrdersParams extends Equatable {
  const OrdersParams({
    required this.page,
    this.sort,
  });

  final int page;
  final OrdersTypes? sort;

  @override
  List<Object?> get props => [page, sort];
}
