import '../../../../core/common/domain/models/pagination.dart';
import '../../../../core/core.dart';
import '../../../../core/utils/enums/orders_types.dart';
import '../models/order_rate_option.dart';
import '../models/order_receipt.dart';
import '../models/user_order.dart';

typedef Orders = ({List<UserOrder> orders, Pagination pagination});

/// Репозиторий для работы с заказами
abstract interface class IOrdersRepository {
  /// Получает заказы
  /// [page] - номер страницы
  /// [sort] - тип сортировки
  Future<Either<Failure, Orders>> getOrders({
    required int page,
    required OrdersTypes? sort,
  });

  /// Получает чек заказа
  /// [id] - id заказа
  Future<Either<Failure, OrderReceipt>> getReceipt({
    required String id,
  });

  /// Получает опции оценки заказа
  /// [rating] - оценка
  /// [id] - id заказа
  Future<Either<Failure, List<OrderRateOption>>> getOrderRateOptions({
    required int rating,
    required String id,
  });

  /// Оценивает заказ
  /// [id] - id заказа
  /// [rating] - оценка
  /// [comment] - комментарий
  /// [optionsIds] - id опций
  Future<Either<Failure, bool>> rateOrder({
    required String id,
    required int rating,
    required String comment,
    required List<String> optionsIds,
  });

  /// Отменяет заказ
  /// [id] - id заказа
  Future<Either<Failure, bool>> cancelOrder({
    required String id,
  });

  /// Повторяет заказ
  /// [id] - id заказа
  Future<Either<Failure, bool>> repeatOrder({
    required String id,
  });

  /// Получает заказ по id
  /// [orderId] - id заказа
  Future<Either<Failure, UserOrder>> getOrderById({
    required String orderId,
  });
}
