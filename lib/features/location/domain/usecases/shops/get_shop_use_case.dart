import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/location/domain/models/shop.dart';
import 'package:niagara_app/features/location/domain/repositories/shops_repository.dart';

@injectable
class GetShopUseCase extends BaseUseCase<Shop, int> {
  GetShopUseCase({
    required IShopsRepository shopRepository,
  }) : _shopRepository = shopRepository;

  final IShopsRepository _shopRepository;

  @override
  Future<Either<Failure, Shop>> call(int params) =>
      _shopRepository.getShopById(id: params);
}
