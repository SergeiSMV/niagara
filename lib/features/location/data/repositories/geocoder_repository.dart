import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/location/data/mappers/geo_to_location_mapper.dart';
import 'package:niagara_app/features/location/domain/entities/location.dart';
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
  Future<Either<Failure, Location>> getAddressByCoordinates({
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
  Future<Either<Failure, List<Location>>> getAddressesByQuery({
    required String query,
  }) async {
    return execute(
      () => _getAddressesByQuery(query: query),
      const SearchAddressFailure(),
    );
  }

  Future<Location> _getAddressByCoordinates({
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

    final featureMembers = res.response?.geoObjectCollection?.featureMember;

    final geoObjects = _extractGeoObjects(featureMembers);
    if (geoObjects.isNotEmpty) {
      final locations = geoObjects.map((e) => e.toLocation()).toList();
      if (locations.isEmpty) throw const AddressDataFailure();
      return locations.first;
    }

    return throw const AddressDataFailure();
  }

  Future<List<Location>> _getAddressesByQuery({
    required String query,
  }) async {
    final res = await _geocoder.getGeocode(
      DirectGeocodeRequest(addressGeocode: query),
    );

    final featureMembers = res.response?.geoObjectCollection?.featureMember;

    final geoObjects = _extractGeoObjects(featureMembers);
    if (geoObjects.isNotEmpty) {
      return geoObjects.map((e) => e.toLocation()).toList();
    }

    return [];
  }

  List<GeoObject> _extractGeoObjects(List<FeatureMember>? featureMembers) {
    return featureMembers
            ?.map((e) => e.geoObject)
            .whereType<GeoObject>()
            .toList() ??
        [];
  }
}
