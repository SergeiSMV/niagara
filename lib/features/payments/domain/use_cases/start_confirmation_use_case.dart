import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/payment_method_type.dart';
import 'package:niagara_app/features/payments/domain/repositories/payments_repository.dart';

@injectable
class StartConfirmationUseCase
    extends BaseUseCase<void, StartConfirmationParams> {
  StartConfirmationUseCase(this._repo);

  final IPaymentsRepository _repo;

  @override
  Future<Either<Failure, void>> call(StartConfirmationParams params) =>
      _repo.startConfirmation(
        confirmationUrl: params.confirmationUrl,
        clientApplicationKey: params.clientKey,
        paymentMethod: params.paymentMethod.toYooKassa(),
        shopId: params.shopId,
      );
}

class StartConfirmationParams {
  StartConfirmationParams({
    required this.confirmationUrl,
    required this.clientKey,
    required this.shopId,
    required this.paymentMethod,
  });

  final String confirmationUrl;
  final String clientKey;
  final String shopId;
  final PaymentMethod paymentMethod;
}
