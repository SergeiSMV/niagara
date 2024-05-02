import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/locations/cities/domain/models/city.dart';
import 'package:niagara_app/features/locations/cities/domain/repositories/cities_repository.dart';

@injectable
class SetCityUseCase extends BaseUseCase<void, City> {
  SetCityUseCase(this._locationRepository);

  final ICitiesRepository _locationRepository;

  @override
  Future<Either<Failure, void>> call(City params) =>
      _locationRepository.setCity(city: params);
}
