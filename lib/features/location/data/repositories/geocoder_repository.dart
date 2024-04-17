import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/location/domain/repositories/geocoder_repository.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart' hide Point;

@LazySingleton(as: IGeocoderRepository)
class GeocoderRepository extends BaseRepository implements IGeocoderRepository {
  GeocoderRepository({
    required YandexGeocoder geocoder,
    required super.logger,
  }) : _geocoder = geocoder;

  final YandexGeocoder _geocoder;

  @override
  Future<Either<Failure, GeoObject>> getAddressByCoordinates({
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

  @override
  Future<Either<Failure, List<GeoObject>>> getAddressesByQuery({
    required String query,
  }) async {
    return execute(
      () => _getAddressesByQuery(query: query),
      const SearchAddressFailure(),
    );
  }

  Future<GeoObject> _getAddressByCoordinates({
    required double latitude,
    required double longitude,
  }) async {
    final res = await _geocoder.getGeocode(
      ReverseGeocodeRequest(
        pointGeocode: (
          lat: latitude,
          lon: longitude,
        ),
      ),
    );

    final geoObject = res
        .response?.geoObjectCollection?.featureMember?.firstOrNull?.geoObject;

    if (geoObject == null) throw const AddressDataFailure();

    return geoObject;
  }

  Future<List<GeoObject>> _getAddressesByQuery({
    required String query,
  }) async {
    final res =
        await _geocoder.getGeocode(DirectGeocodeRequest(addressGeocode: query));
    final featureMembers = res.response?.geoObjectCollection?.featureMember;

    if (featureMembers != null) {
      return featureMembers.map((e) => e.geoObject!).toList();
    }

    return [];
  }
}
