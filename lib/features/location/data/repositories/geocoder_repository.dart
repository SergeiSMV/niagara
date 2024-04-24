import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/location/data/mappers/geo_to_location_mapper.dart';
import 'package:niagara_app/features/location/domain/entities/locality.dart';

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
  Failure get failure => const GeocoderRepositoryFailure();

  @override
  Future<Either<Failure, Location>> getAddressByCoordinates({
    required double latitude,
    required double longitude,
  }) =>
      execute(
        () async {
          final res = await _geocoder.getGeocode(
            ReverseGeocodeRequest(
              pointGeocode: (
                lat: latitude,
                lon: longitude,
              ),
            ),
          );

          final featureMembers =
              res.response?.geoObjectCollection?.featureMember;

          final geoObjects = _extractGeoObjects(featureMembers);
          if (geoObjects.isNotEmpty) {
            final locations = geoObjects.map((e) => e.toLocation()).toList();
            if (locations.isEmpty) throw const AddressDataFailure();
            return locations.first;
          }

          return throw const AddressDataFailure();
        },
      );

  @override
  Future<Either<Failure, List<Location>>> getAddressesByQuery({
    required String query,
  }) async =>
      execute(() async {
        final res = await _geocoder.getGeocode(
          DirectGeocodeRequest(addressGeocode: query),
        );

        final featureMembers = res.response?.geoObjectCollection?.featureMember;

        final geoObjects = _extractGeoObjects(featureMembers);
        if (geoObjects.isNotEmpty) {
          return geoObjects.map((e) => e.toLocation()).toList();
        }

        return [];
      });

  List<GeoObject> _extractGeoObjects(List<FeatureMember>? featureMembers) {
    return featureMembers
            ?.map((e) => e.geoObject)
            .whereType<GeoObject>()
            .toList() ??
        [];
  }
}
