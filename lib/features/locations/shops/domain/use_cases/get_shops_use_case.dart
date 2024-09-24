import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/locations/shops/domain/models/shop.dart';
import 'package:niagara_app/features/locations/shops/domain/repositories/shops_repository.dart';

@injectable
class GetShopsUseCase extends BaseUseCase<List<Shop>, NoParams> {
  GetShopsUseCase(this._shopRepository);

  final IShopsRepository _shopRepository;

  @override
  Future<Either<Failure, List<Shop>>> call([NoParams? params]) =>
      _shopRepository.getShops();
}
