import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/order_placing/domain/models/delivery_time_options.dart';
import 'package:niagara_app/features/order_placing/domain/repositories/order_placing_repository.dart';

@injectable
class GetDeliveryTimeOptionsUseCase
    extends BaseUseCase<List<DeliveryTimeOptions>, NoParams> {
  const GetDeliveryTimeOptionsUseCase(this._repo);

  final IOrderPlacingRepository _repo;

  @override
  Future<Either<Failure, List<DeliveryTimeOptions>>> call(
    NoParams params,
  ) async =>
      _repo.getDeliveryTimeOptions(
        locationId: '86a7f7b4-67ff-44af-9d00-d517aced756b',
      );
}
