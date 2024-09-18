import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

@RoutePage()
class CatalogWrapper implements AutoRouteWrapper {
  const CatalogWrapper();

  @override
  Widget wrappedRoute(BuildContext context) => const AutoRouter();
}
