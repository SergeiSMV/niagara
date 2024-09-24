import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/payment_statuses.dart';
import 'package:niagara_app/features/payments/domain/repositories/payments_repository.dart';

@injectable
class GetPaymentStatusUseCase extends BaseUseCase<PaymentStatus, String> {
  GetPaymentStatusUseCase(this._repo);

  final IPaymentsRepository _repo;

  @override
  Future<Either<Failure, PaymentStatus>> call(String orderId) =>
      _repo.getPaymentStatus(
        orderId: orderId,
      );
}
