import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/router/base_route.dart';

/// Класс роутера для модуля локаций
@lazySingleton
class LocationsRouters implements BaseRouters {
  @override
  AutoRoute get routers => AutoRoute(
        page: LocationsWrapperRoute.page,
        children: [
          AutoRoute(page: AddressSelectionRoute.page, initial: true),
        ],
      );
}
