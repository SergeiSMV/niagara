import '../../../../../../core/core.dart';
import '../../models/address.dart';
import '../../repositories/address_repository.dart';

/// Usecase для установки адреса по умолчанию
@injectable
class SetDefaultAddressUseCase extends BaseUseCase<void, Address> {
  SetDefaultAddressUseCase(this._repository);

  /// Репозиторий адресов
  final IAddressRepository _repository;

  /// Установить адрес по умолчанию
  @override
  Future<Either<Failure, void>> call(Address params) =>
      _repository.setDefaultAddress(params);
}
