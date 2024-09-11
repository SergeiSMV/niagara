import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/payment_method_type.dart';
import 'package:niagara_app/features/order_placing/domain/models/tokenization_data.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/activation_option.dart';
import 'package:niagara_app/features/vip/domain/repositories/vip_order_repository.dart';

@injectable
class OrderVipUseCase extends BaseUseCase<TokenizationData, OrderVipParams> {
  OrderVipUseCase(this._repo);

  final IVipOrderRepository _repo;

  @override
  Future<Either<Failure, TokenizationData>> call(
    OrderVipParams params,
  ) async =>
      _repo.createOrder(
        paymentMethod: params.paymentMethod,
        activationOption: params.activationOption,
      );
}

class OrderVipParams {
  OrderVipParams({
    required this.paymentMethod,
    required this.activationOption,
  });

  final PaymentMethod paymentMethod;
  final ActivationOption activationOption;
}
