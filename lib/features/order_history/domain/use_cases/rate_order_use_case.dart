import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/order_history/domain/repositories/orders_repository.dart';

@injectable
class RateOrderUseCase extends BaseUseCase<bool, RateOrderParams> {
  const RateOrderUseCase(this._ordersRepository);

  final IOrdersRepository _ordersRepository;

  @override
  Future<Either<Failure, bool>> call(
    RateOrderParams params,
  ) async =>
      _ordersRepository.rateOrder(
        id: params.id,
        rating: params.rating,
        comment: params.comment,
        optionsIds: params.optionsIds,
      );
}

class RateOrderParams extends Equatable {
  const RateOrderParams({
    required this.id,
    required this.rating,
    required this.comment,
    required this.optionsIds,
  });

  final String id;
  final int rating;
  final String comment;
  final List<String> optionsIds;

  @override
  List<Object?> get props => [
        id,
        rating,
        comment,
        optionsIds,
      ];
}
