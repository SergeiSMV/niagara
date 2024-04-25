import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/location/domain/models/location.dart';
import 'package:niagara_app/features/location/domain/repositories/geocoder_repository.dart';
import 'package:yandex_mapkit_lite/yandex_mapkit_lite.dart';

@injectable
class GetAddressUseCase extends BaseUseCase<Location, Point> {
  GetAddressUseCase({
    required IGeocoderRepository geocoder,
  }) : _geocoder = geocoder;

  final IGeocoderRepository _geocoder;

  @override
  Future<Either<Failure, Location>> call(Point params) async =>
      _geocoder.getAddressByCoordinates(
        latitude: params.latitude,
        longitude: params.longitude,
      );
}
