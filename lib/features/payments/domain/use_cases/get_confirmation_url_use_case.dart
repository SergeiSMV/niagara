import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/payments/domain/model/paument_confirmation_info.dart';
import 'package:niagara_app/features/payments/domain/repositories/payments_repository.dart';

@injectable
class GetConfirmationUrlUseCase
    extends BaseUseCase<PaymentConfirmationInfo, GetConfirmationUrlParams> {
  GetConfirmationUrlUseCase(this._repo);

  final IPaymentsRepository _repo;

  @override
  Future<Either<Failure, PaymentConfirmationInfo>> call(
    GetConfirmationUrlParams params,
  ) =>
      _repo.getConfirmationUrl(
        orderId: params.orderId,
        paymentToken: params.paymentToken,
      );
}

class GetConfirmationUrlParams {
  GetConfirmationUrlParams({
    required this.orderId,
    required this.paymentToken,
  });

  final String orderId;
  final String paymentToken;
}
