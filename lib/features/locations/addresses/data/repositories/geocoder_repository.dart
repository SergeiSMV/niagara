import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/locations/addresses/data/mappers/geoobject_mapper.dart';
import 'package:niagara_app/features/locations/addresses/domain/models/address.dart';
import 'package:niagara_app/features/locations/addresses/domain/repositories/geocoder_repository.dart';
import 'package:niagara_app/features/locations/cities/data/local/data_source/cities_local_data_source.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart' as geo;

@LazySingleton(as: IGeocoderRepository)
class GeocoderRepository extends BaseRepository implements IGeocoderRepository {
  GeocoderRepository(
    super._logger,
    this._geocoder,
    this._citiesLDS,
  );

  final geo.YandexGeocoder _geocoder;
  final ICitiesLocalDataSource _citiesLDS;

  @override
  Failure get failure => const GeocoderRepositoryFailure();

  @override
  Future<Either<Failure, Address>> getAddressByCoordinates({
    required double latitude,
    required double longitude,
  }) =>
      execute(
        () async {
          final res = await _geocoder.getGeocode(
            geo.ReverseGeocodeRequest(
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
  Future<Either<Failure, List<Address>>> getAddressesByQuery({
    required String query,
  }) async =>
      execute(() async {
        final city = await _citiesLDS.getCity().fold(
              (failure) => throw failure,
              (city) => city,
            );

        final res = await _geocoder.getGeocode(
          geo.DirectGeocodeRequest(
            addressGeocode: query,
            kind: geo.KindRequest.house,
            ll: geo.SearchAreaLL(
              latitude: city.latitude,
              longitude: city.longitude,
            ),
            results: 20,
            lang: geo.Lang.ru,
          ),
        );

        final featureMembers = res.response?.geoObjectCollection?.featureMember;

        final geoObjects = _extractGeoObjects(featureMembers);
        if (geoObjects.isNotEmpty) {
          return geoObjects.map((e) => e.toLocation()).toList();
        }

        return [];
      });

  List<geo.GeoObject> _extractGeoObjects(
    List<geo.FeatureMember>? featureMembers,
  ) =>
      featureMembers
          ?.map((e) => e.geoObject)
          .whereType<geo.GeoObject>()
          .toList() ??
      [];
}
