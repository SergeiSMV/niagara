import 'package:auto_route/auto_route.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/location/domain/usecases/cities/get_city_use_case.dart';
import 'package:niagara_app/features/location/presentation/location_guard.dart';

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

  static LocationGuard get locationGuard => LocationGuard(
        getCityUseCase: getIt<GetCityUseCase>(),
      );
}
