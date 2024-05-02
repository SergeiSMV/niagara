import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/locations/cities/domain/models/city.dart';
import 'package:niagara_app/features/locations/cities/domain/repositories/cities_repository.dart';

@injectable
class GetCityUseCase extends BaseUseCase<City, NoParams> {
  GetCityUseCase(this._locationRepository);

  final ICitiesRepository _locationRepository;

  @override
  Future<Either<Failure, City>> call([NoParams? params]) =>
      _locationRepository.getCity();
}
