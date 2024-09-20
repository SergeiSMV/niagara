import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/order_history/domain/repositories/orders_repository.dart';

@injectable
class CancelOrderUseCase extends BaseUseCase<bool, String> {
  const CancelOrderUseCase(this._ordersRepository);

  final IOrdersRepository _ordersRepository;

  @override
  Future<Either<Failure, bool>> call(
    String id,
  ) async =>
      _ordersRepository.cancelOrder(
        id: id,
      );
}
