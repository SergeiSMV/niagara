import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/location/domain/entities/locality.dart';
import 'package:niagara_app/features/location/domain/repositories/cities_repository.dart';

@injectable
class SetCityUseCase extends BaseUseCase<void, City> {
  SetCityUseCase({
    required ICitiesRepository locationRepository,
  }) : _locationRepository = locationRepository;

  final ICitiesRepository _locationRepository;

  @override
  Future<Either<Failure, void>> call(City params) =>
      _locationRepository.setCity(city: params);
}
