import 'package:niagara_app/core/common/domain/models/pagination.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/orders_types.dart';
import 'package:niagara_app/features/order_history/domain/models/order_rate_option.dart';
import 'package:niagara_app/features/order_history/domain/models/order_receipt.dart';
import 'package:niagara_app/features/order_history/domain/models/user_order.dart';

typedef Orders = ({List<UserOrder> orders, Pagination pagination});

abstract interface class IOrdersRepository {
  Future<Either<Failure, Orders>> getOrders({
    required int page,
    required OrdersTypes? sort,
  });

  Future<Either<Failure, OrderReceipt>> getReceipt({
    required String id,
  });

  Future<Either<Failure, List<OrderRateOption>>> getOrderRateOptions({
    required int rating,
    required String id,
  });

  Future<Either<Failure, bool>> rateOrder({
    required String id,
    required int rating,
    required String comment,
    required List<String> optionsIds,
  });

  Future<Either<Failure, bool>> cancelOrder({
    required String id,
  });

  Future<Either<Failure, bool>> repeatOrder({
    required String id,
  });
}
