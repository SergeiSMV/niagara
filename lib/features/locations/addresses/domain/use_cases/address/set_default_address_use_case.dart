import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/locations/addresses/domain/models/address.dart';
import 'package:niagara_app/features/locations/addresses/domain/repositories/address_repository.dart';

@injectable
class SetDefaultAddressUseCase extends BaseUseCase<void, Address> {
  SetDefaultAddressUseCase(this._repository);

  final IAddressRepository _repository;

  @override
  Future<Either<Failure, void>> call(Address params) =>
      _repository.setDefaultAddress(params);
}
