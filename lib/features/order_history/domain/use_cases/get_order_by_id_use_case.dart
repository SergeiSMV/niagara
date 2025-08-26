import '../../../../core/core.dart';
import '../models/user_order.dart';
import '../repositories/orders_repository.dart';

/// Usecase для получения заказа по id
@injectable
class GetOrderByIdUseCase extends BaseUseCase<UserOrder?, String> {
  const GetOrderByIdUseCase(this._orderRepository);

  /// Репозиторий для работы с заказами
  final IOrdersRepository _orderRepository;

  /// Получает заказ по id
  @override
  Future<Either<Failure, UserOrder?>> call(String orderId) async =>
      await _orderRepository.getOrderById(orderId: orderId);
}
