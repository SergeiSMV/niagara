import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/order_history/domain/repositories/orders_repository.dart';

@injectable
class EvaluateOrderUseCase extends BaseUseCase<bool, EvaluateOrderParams> {
  const EvaluateOrderUseCase(this._ordersRepository);

  final IOrdersRepositories _ordersRepository;

  @override
  Future<Either<Failure, bool>> call(
    EvaluateOrderParams params,
  ) async =>
      _ordersRepository.evaluateOrder(
        id: params.id,
        rating: params.rating,
        description: params.description,
        optionsIds: params.optionsIds,
      );
}

class EvaluateOrderParams extends Equatable {
  const EvaluateOrderParams({
    required this.id,
    required this.rating,
    required this.description,
    required this.optionsIds,
  });

  final String id;
  final String rating;
  final String description;
  final List<String> optionsIds;

  @override
  List<Object?> get props => [
        id,
        rating,
        description,
        optionsIds,
      ];
}
