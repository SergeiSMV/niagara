import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/tabs_navigation_widget.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

@RoutePage()
class LocationsTabPage extends StatelessWidget {
  const LocationsTabPage({super.key});

  static final _tabs = [
    AppTabItem(
      route: const AddressesRoute(),
      title: t.locations.delivery,
      icon: Assets.icons.boxFill,
    ),
    AppTabItem(
      route: const ShopsRoute(),
      title: t.shops.shops,
      icon: Assets.icons.shop,
    ),
  ];

  @override
  Widget build(BuildContext context) => TabsNavigationWidget(tabs: _tabs);
}
