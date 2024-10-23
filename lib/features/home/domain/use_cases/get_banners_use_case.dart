import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/home/domain/models/banner.dart';
import 'package:niagara_app/features/home/domain/repositories/banners_repository.dart';

@injectable
class GetBannersUseCase extends BaseUseCase<List<Banner>, NoParams> {
  const GetBannersUseCase(this._bannersRepository);

  final IBannersRepository _bannersRepository;

  @override
  Future<Either<Failure, List<Banner>>> call(NoParams params) async =>
      _bannersRepository.getBanners();
}
