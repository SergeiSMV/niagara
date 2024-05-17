import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

@RoutePage()
class LocationsTabPage extends StatelessWidget {
  const LocationsTabPage({super.key});

  static final _tabs = [
    _TabItem(
      route: const AddressesRoute(),
      title: t.locations.delivery,
      icon: Assets.icons.boxFill,
    ),
    _TabItem(
      route: const ShopsRoute(),
      title: t.shops.shops,
      icon: Assets.icons.shop,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.tabBar(
      routes: _tabs.map((e) => e.route).toList(),
      physics: const NeverScrollableScrollPhysics(),
      builder: (_, child, ctrl) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const AppBarWidget(),
        body: Stack(
          children: [
            child,
            SafeArea(
              child: Padding(
                padding: AppInsets.kSymmetricH16,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: context.colors.mainColors.bgCard,
                    borderRadius: BorderRadius.circular(AppSizes.kGeneral12),
                    boxShadow: [
                      BoxShadow(
                        color: context.colors.textColors.main
                            .withOpacity(AppSizes.kShadowOpacity),
                        offset: AppConstants.kShadowBottom,
                        blurRadius: AppSizes.kGeneral12,
                      ),
                    ],
                  ),
                  child: TabBar(
                    controller: ctrl,
                    padding: AppInsets.kSymmetricV4,
                    tabs: _tabs
                        .map(
                          (t) => _buildTab(
                            context,
                            icon: t.icon,
                            title: t.title,
                            isSelected: ctrl.index == _tabs.indexOf(t),
                          ),
                        )
                        .toList(),
                    dividerHeight: 0,
                    splashFactory: NoSplash.splashFactory,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSizes.kGeneral8),
                      color: context.colors.mainColors.white,
                    ),
                    indicatorPadding: AppInsets.kSymmetricH4,
                    indicatorSize: TabBarIndicatorSize.tab,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(
    BuildContext context, {
    required SvgGenImage icon,
    required String title,
    required bool isSelected,
  }) {
    return Padding(
      padding: AppInsets.kSymmetricV12,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.kGeneral12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon.svg(
              width: AppSizes.kIconMedium,
              height: AppSizes.kIconMedium,
              colorFilter: ColorFilter.mode(
                isSelected
                    ? context.colors.mainColors.primary
                    : context.colors.fieldBordersColors.main,
                BlendMode.srcIn,
              ),
            ),
            AppBoxes.kBoxH8,
            Text(
              title,
              style: context.textStyle.textTypo.tx2SemiBold
                  .withColor(context.colors.textColors.main),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabItem {
  const _TabItem({
    required this.route,
    required this.title,
    required this.icon,
  });

  final PageRouteInfo<dynamic> route;
  final String title;
  final SvgGenImage icon;
}
