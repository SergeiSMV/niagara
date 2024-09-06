import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/order_placing/domain/models/tokenization_data.dart';
import 'package:niagara_app/features/payments/domain/repositories/payments_repository.dart';

@injectable
class StartTokenizationUseCase extends BaseUseCase<String?, TokenizationData> {
  StartTokenizationUseCase(this._paymentsRepository);

  final IPaymentsRepository _paymentsRepository;

  @override
  Future<Either<Failure, String?>> call(TokenizationData params) =>
      _paymentsRepository.startTokenization(
        amountRub: params.price,
        clientApplicationKey: params.applicationKey,
        paymentMethod: params.paymentMethod.toYooKassa(),
        shopId: params.shopId,
        subtitle: params.description,
        title: params.title,
        customerId: params.customerId,
      );
}
