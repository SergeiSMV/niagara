import 'package:niagara_app/core/common/domain/models/pagination.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/orders_types.dart';
import 'package:niagara_app/features/order_history/domain/models/user_order.dart';

typedef Orders = ({List<UserOrder> orders, Pagination pagination});

abstract interface class IOrdersRepositories {
  Future<Either<Failure, Orders>> getOrders({
    required int page,
    required OrdersTypes sort,
  });
}
