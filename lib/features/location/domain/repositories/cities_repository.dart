import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/location/domain/models/city.dart';

abstract interface class ICitiesRepository {
  /// Получает список городов из сети.
  Future<Either<Failure, List<City>>> getCities();

  /// Устанавливает город по умолчанию.
  Future<Either<Failure, void>> setCity({required City city});

  /// Получает город по умолчанию.
  Future<Either<Failure, City>> getCity();
}
