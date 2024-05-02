import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/locations/addresses/domain/models/address.dart';
import 'package:niagara_app/features/locations/addresses/domain/repositories/address_repository.dart';

@injectable
class GetAddressesUseCase extends BaseUseCase<List<Address>, NoParams> {
  GetAddressesUseCase(this._repository);

  final IAddressRepository _repository;

  @override
  Future<Either<Failure, List<Address>>> call([NoParams? params]) =>
      _repository.getAddresses();
}
