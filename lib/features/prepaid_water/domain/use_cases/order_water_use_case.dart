import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/payment_method_type.dart';
import 'package:niagara_app/features/order_placing/domain/models/tokenization_data.dart';
import 'package:niagara_app/features/prepaid_water/domain/model/prepaid_water_order_data.dart';
import 'package:niagara_app/features/prepaid_water/domain/repository/order_water_repository.dart';

@injectable
class OrderWaterUseCase
    extends BaseUseCase<TokenizationData, OrderWaterParams> {
  OrderWaterUseCase(this._repo);

  final IOrderWaterRepository _repo;

  @override
  Future<Either<Failure, TokenizationData>> call(
    OrderWaterParams params,
  ) async =>
      _repo.createOrder(
        paymentMethod: params.paymentMethod,
        orderData: params.orderData,
      );
}

class OrderWaterParams {
  OrderWaterParams({
    required this.paymentMethod,
    required this.orderData,
  });

  final PaymentMethod paymentMethod;
  final OrderWaterData orderData;
}
