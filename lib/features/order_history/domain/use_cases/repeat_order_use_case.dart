import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/order_history/domain/repositories/orders_repository.dart';

@injectable
class RepeatOrderUseCase extends BaseUseCase<bool, String> {
  const RepeatOrderUseCase(this._ordersRepository);

  final IOrdersRepository _ordersRepository;

  @override
  Future<Either<Failure, bool>> call(
    String id,
  ) async =>
      _ordersRepository.repeatOrder(
        id: id,
      );
}
