import 'package:auto_route/auto_route.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/location/presentation/locations/location_guard.dart';
import 'package:niagara_app/features/location/presentation/select_city/city_guard.dart';

abstract final class LocationsRouters {
  static AutoRoute get routers => AutoRoute(
        page: LocationsWrapperRoute.page,
        children: [
          AutoRoute(
            page: CitiesRoute.page,
            title: (_, __) => t.cities.yourCity,
          ),
          AutoRoute(
            page: LocationsNavigatorRoute.page,
            children: [
              AutoRoute(
                page: LocationsRoute.page,
                initial: true,
                title: (_, __) => t.locations.myAddresses,
                guards: [locationGuard],
              ),
              AutoRoute(
                page: ShopsRoute.page,
                title: (_, __) => t.shops.shops,
              ),
            ],
          ),
          AutoRoute(
            page: AddingAddressWrapperRoute.page,
            children: [
              AutoRoute(
                page: ChoiceOnMapRoute.page,
                title: (_, __) => t.locations.deliveryAddress,
              ),
              AutoRoute(page: SearchAddressRoute.page),
            ],
          ),
          AutoRoute(
            page: EditLocationRoute.page,
            title: (_, __) => t.locations.editAddress,
          ),
        ],
      );

  static CityGuard get cityGuard => getIt<CityGuard>();
  static LocationGuard get locationGuard => getIt<LocationGuard>();
}
