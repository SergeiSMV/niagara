import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/locations/addresses/domain/models/address.dart';
import 'package:niagara_app/features/locations/addresses/domain/repositories/address_repository.dart';

@injectable
class CheckingForDeliverabilityUseCase extends BaseUseCase<bool, Address> {
  CheckingForDeliverabilityUseCase(this._repository);

  final IAddressRepository _repository;

  @override
  Future<Either<Failure, bool>> call(Address params) =>
      _repository.checkDelivery(params);
}
