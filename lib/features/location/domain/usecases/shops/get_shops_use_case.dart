import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/location/domain/models/shop.dart';
import 'package:niagara_app/features/location/domain/repositories/shops_repository.dart';

@injectable
class GetShopsUseCase extends BaseUseCase<List<Shop>, NoParams> {
  GetShopsUseCase({
    required IShopsRepository shopRepository,
  }) : _shopRepository = shopRepository;

  final IShopsRepository _shopRepository;

  @override
  Future<Either<Failure, List<Shop>>> call([NoParams? params]) =>
      _shopRepository.getShops();
}
