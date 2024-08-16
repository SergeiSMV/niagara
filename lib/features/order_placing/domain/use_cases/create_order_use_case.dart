import 'package:niagara_app/core/common/domain/models/time_slot.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/payment_method_type.dart';
import 'package:niagara_app/features/order_placing/domain/models/tokenization_data.dart';
import 'package:niagara_app/features/order_placing/domain/repositories/order_placing_repository.dart';

@injectable
class CreateOrderUseCase
    extends BaseUseCase<TokenizationData, CreateOrderParams> {
  CreateOrderUseCase(this._repo);

  final IOrderPlacingRepository _repo;

  @override
  Future<Either<Failure, TokenizationData>> call(
    CreateOrderParams params,
  ) async =>
      _repo.createOrder(
        deliveryDate: params.deliveryDate,
        timeSlot: params.timeSlot,
        paymentMethod: params.paymentMethod,
        comment: params.comment,
      );
}

class CreateOrderParams {
  CreateOrderParams({
    required this.deliveryDate,
    required this.timeSlot,
    required this.paymentMethod,
    this.comment,
  });

  final DateTime deliveryDate;
  final TimeSlot timeSlot;
  final PaymentMethod paymentMethod;
  final String? comment;
}
