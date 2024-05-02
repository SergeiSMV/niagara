import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

@RoutePage()
class ProfileWrapper implements AutoRouteWrapper {
  const ProfileWrapper();

  @override
  Widget wrappedRoute(BuildContext context) => const AutoRouter();
}
