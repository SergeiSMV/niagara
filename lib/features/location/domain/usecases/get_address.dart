import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/core.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart' as map;

@injectable
class GetAddressUseCase extends UseCase<String, map.Point> {
  GetAddressUseCase({
    required YandexGeocoder geocoder,
  }) : _geocoder = geocoder;

  final YandexGeocoder _geocoder;

  @override
  Future<Either<Failure, String>> call(map.Point params) async {
    final res = await _geocoder.getGeocode(
      ReverseGeocodeRequest(
        pointGeocode: (lat: params.latitude, lon: params.longitude),
      ),
    );

    if (res.firstAddress == null) return const Left(AddressDataFailure());
    final street = res.firstAddress!.components!
        .firstWhere((element) => element.kind == KindResponse.street)
        .name;

    final house = res.firstAddress!.components!
        .firstWhere((element) => element.kind == KindResponse.house)
        .name;
    return Right('$street, $house');
  }
}
