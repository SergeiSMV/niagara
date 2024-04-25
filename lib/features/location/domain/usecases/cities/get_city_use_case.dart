import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/location/domain/models/city.dart';
import 'package:niagara_app/features/location/domain/repositories/cities_repository.dart';

@injectable
class GetCityUseCase extends BaseUseCase<City, NoParams> {
  GetCityUseCase({
    required ICitiesRepository locationRepository,
  }) : _locationRepository = locationRepository;

  final ICitiesRepository _locationRepository;

  @override
  Future<Either<Failure, City>> call([NoParams? params]) =>
      _locationRepository.getCity();
}
