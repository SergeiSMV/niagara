import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/locations/cities/domain/models/city.dart';
import 'package:niagara_app/features/locations/cities/domain/repositories/cities_repository.dart';

@injectable
class GetCitiesUseCase extends BaseUseCase<List<City>, NoParams> {
  GetCitiesUseCase(this._locationRepository);

  final ICitiesRepository _locationRepository;

  @override
  Future<Either<Failure, List<City>>> call([NoParams? params]) =>
      _locationRepository.getCities();
}
