import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/order_history/domain/models/order_rate_option.dart';
import 'package:niagara_app/features/order_history/domain/repositories/orders_repository.dart';

@injectable
class GetOrderRateOptionsUseCase
    extends BaseUseCase<List<OrderRateOption>, GetOrderRateOptionsParams> {
  const GetOrderRateOptionsUseCase(this._ordersRepository);

  final IOrdersRepository _ordersRepository;

  @override
  Future<Either<Failure, List<OrderRateOption>>> call(
    GetOrderRateOptionsParams params,
  ) =>
      _ordersRepository.getOrderRateOptions(
        rating: params.rating,
        id: params.id,
      );
}

class GetOrderRateOptionsParams extends Equatable {
  const GetOrderRateOptionsParams({
    required this.rating,
    required this.id,
  });

  final int rating;
  final String id;

  @override
  List<Object?> get props => [
        rating,
        id,
      ];
}
