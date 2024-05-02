import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/locations/addresses/domain/models/address.dart';
import 'package:niagara_app/features/locations/addresses/domain/repositories/geocoder_repository.dart';
import 'package:yandex_mapkit_lite/yandex_mapkit_lite.dart';

@injectable
class GetAddressByPointUseCase extends BaseUseCase<Address, Point> {
  GetAddressByPointUseCase(this._geocoder);

  final IGeocoderRepository _geocoder;

  @override
  Future<Either<Failure, Address>> call(Point params) async =>
      _geocoder.getAddressByCoordinates(
        latitude: params.latitude,
        longitude: params.longitude,
      );
}
