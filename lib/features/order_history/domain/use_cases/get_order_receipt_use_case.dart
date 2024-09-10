import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/order_history/domain/models/order_receipt.dart';
import 'package:niagara_app/features/order_history/domain/repositories/orders_repository.dart';

@injectable
class GetOrderReceiptUseCase extends BaseUseCase<OrderReceipt, String> {
  GetOrderReceiptUseCase(this._ordersRepository);

  final IOrdersRepository _ordersRepository;

  @override
  Future<Either<Failure, OrderReceipt>> call(String params) =>
      _ordersRepository.getReceipt(id: params);
}
