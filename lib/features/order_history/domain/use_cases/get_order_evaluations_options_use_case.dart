import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/order_history/domain/models/order_evaluation_option.dart';
import 'package:niagara_app/features/order_history/domain/repositories/orders_repository.dart';

@injectable
class GetOrderEvaluationsOptionsUseCase
    extends BaseUseCase<List<OrderEvaluationOption>, String> {
  const GetOrderEvaluationsOptionsUseCase(this._ordersRepository);

  final IOrdersRepositories _ordersRepository;

  @override
  Future<Either<Failure, List<OrderEvaluationOption>>> call(
    String rating,
  ) async =>
      _ordersRepository.getOrderEvaluationOptions(rating: rating);
}
