import 'package:auto_route/auto_route.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/locations/addresses/presentation/addresses/addresses_guard.dart';
import 'package:niagara_app/features/locations/cities/presentation/city_guard.dart';

abstract final class LocationsRouters {
  static AutoRoute get routers => AutoRoute(
        page: LocationsWrapper.page,
        children: [
          AutoRoute(
            page: CitiesRoute.page,
            title: (_, __) => t.cities.yourCity,
          ),
          AutoRoute(
            page: LocationsTabRoute.page,
            children: [
              AutoRoute(
                page: AddressesRoute.page,
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
            page: EditAddressRoute.page,
            title: (_, __) => t.locations.editAddress,
          ),
        ],
      );

  static CityGuard get cityGuard => getIt<CityGuard>();

  static AddressesGuard get locationGuard => getIt<AddressesGuard>();
}
