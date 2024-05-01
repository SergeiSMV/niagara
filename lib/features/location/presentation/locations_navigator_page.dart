import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

@RoutePage()
class LocationsNavigatorPage extends StatelessWidget {
  const LocationsNavigatorPage({super.key});

  static final _tabs = [
    _TabItem(
      route: const LocationsRoute(),
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
  Widget build(BuildContext context) => AutoTabsRouter.tabBar(
        routes: _tabs.map((e) => e.route).toList(),
        physics: const NeverScrollableScrollPhysics(),
        builder: (_, child, ctrl) => Scaffold(
          extendBodyBehindAppBar: true,
          appBar: const AppBarWidget(),
          body: Stack(
            children: [
              child,
              SafeArea(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: context.colors.mainColors.bgCard,
                    borderRadius: BorderRadius.circular(AppConst.kButtonRadius),
                    boxShadow: [
                      BoxShadow(
                        color: context.colors.textColors.main
                            .withOpacity(AppConst.kShadowOpacity),
                        offset: AppConst.kShadowBottom,
                        blurRadius: AppConst.kShadowBlur,
                      ),
                    ],
                  ),
                  child: TabBar(
                    controller: ctrl,
                    padding: AppConst.kCommon4.vertical,
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
                      borderRadius: BorderRadius.circular(AppConst.kCommon8),
                      color: context.colors.mainColors.white,
                    ),
                    indicatorPadding: AppConst.kCommon4.horizontal,
                    indicatorSize: TabBarIndicatorSize.tab,
                  ),
                ).paddingSymmetric(horizontal: AppConst.kCommon16),
              ),
            ],
          ),
        ),
      );

  Widget _buildTab(
    BuildContext context, {
    required SvgGenImage icon,
    required String title,
    required bool isSelected,
  }) =>
      DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConst.kButtonRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon.svg(
              width: AppConst.kIconMedium,
              height: AppConst.kIconMedium,
              colorFilter: ColorFilter.mode(
                isSelected
                    ? context.colors.mainColors.primary
                    : context.colors.fieldBordersColors.main,
                BlendMode.srcIn,
              ),
            ),
            AppConst.kCommon8.horizontalBox,
            Text(
              title,
              style: context.textStyle.textTypo.tx2SemiBold
                  .withColor(context.colors.textColors.main),
            ),
          ],
        ),
      ).paddingSymmetric(vertical: AppConst.kCommon12);
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
