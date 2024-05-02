import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/locations/addresses/domain/repositories/address_repository.dart';

@injectable
class HasAddressesUseCase extends BaseUseCase<bool, NoParams> {
  HasAddressesUseCase(this._repository);

  final IAddressRepository _repository;

  @override
  Future<Either<Failure, bool>> call([NoParams? params]) =>
      _repository.getAddresses().fold(
            (failure) => throw failure,
            (addresses) => Right(addresses.isNotEmpty),
          );
}
