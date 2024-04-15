import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/location/domain/repositories/geocoder_repository.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart';

@LazySingleton(as: IGeocoderRepository)
class GeocoderRepository extends BaseRepository implements IGeocoderRepository {
  GeocoderRepository({
    required YandexGeocoder geocoder,
    required super.logger,
  }) : _geocoder = geocoder;

  final YandexGeocoder _geocoder;

  @override
  Future<Either<Failure, String>> getAddressByCoordinates({
    required double latitude,
    required double longitude,
  }) {
    return execute(
      () => _getAddressByCoordinates(
        latitude: latitude,
        longitude: longitude,
      ),
      const AddressDataFailure(),
    );
  }

  Future<String> _getAddressByCoordinates({
    required double latitude,
    required double longitude,
  }) async {
    final res = await _geocoder.getGeocode(
      ReverseGeocodeRequest(pointGeocode: (lat: latitude, lon: longitude)),
    );

    if (res.firstAddress == null) throw const AddressDataFailure();
    final street = res.firstAddress!.components!
        .firstWhere((element) => element.kind == KindResponse.street)
        .name;

    final house = res.firstAddress!.components!
        .firstWhere((element) => element.kind == KindResponse.house)
        .name;
    return '$street, $house';
  }
}
