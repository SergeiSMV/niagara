import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/location/domain/repositories/geocoder_repository.dart';
import 'package:yandex_mapkit_lite/yandex_mapkit_lite.dart';

@injectable
class GetAddressUseCase extends BaseUseCase<String, Point> {
  GetAddressUseCase({
    required IGeocoderRepository geocoder,
  }) : _geocoder = geocoder;

  final IGeocoderRepository _geocoder;

  @override
  Future<Either<Failure, String>> call(Point params) async {
    final location = _geocoder.getAddressByCoordinates(
      latitude: params.latitude,
      longitude: params.longitude,
    );

    return location.fold(Left.new, (location) {
      final name = location.name;
      return Right(name);
    });
  }
}
