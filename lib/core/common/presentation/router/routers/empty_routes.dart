import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';

@RoutePage()
class EmptyNavigatorPage extends StatelessWidget {
  const EmptyNavigatorPage({super.key});

  @override
  Widget build(BuildContext context) => const AutoRouter();
}

abstract final class EmptyRouters {
  static AutoRoute get routers => AutoRoute(page: EmptyNavigatorRoute.page);
}
