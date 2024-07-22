import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/order_history/domain/models/order_rate_option.dart';
import 'package:niagara_app/features/order_history/domain/repositories/orders_repository.dart';

@injectable
class GetOrderRateOptionsUseCase
    extends BaseUseCase<List<OrderRateOption>, int> {
  const GetOrderRateOptionsUseCase(this._ordersRepository);

  final IOrdersRepositories _ordersRepository;

  @override
  Future<Either<Failure, List<OrderRateOption>>> call(
    int rating,
  ) async =>
      _ordersRepository.getOrderRateOptions(rating: rating);
}
