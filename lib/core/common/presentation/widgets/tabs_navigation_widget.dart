import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/app_borders.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/app_insets.dart';
import '../../../utils/constants/app_sizes.dart';
import '../../../utils/extensions/build_context_ext.dart';
import '../../../utils/extensions/text_style_ext.dart';
import '../../../utils/gen/assets.gen.dart';
import 'app_bar.dart';

/// модель таба
class AppTabItem {
  const AppTabItem({
    required this.route,
    required this.title,
    this.appBarActions,
    this.icon,
  });

  /// маршрут таба
  final PageRouteInfo<dynamic> route;

  /// заголовок таба
  final String title;

  /// иконка таба
  final SvgGenImage? icon;

  /// действия в appBar
  final List<Widget>? appBarActions;
}

/// виджет табов
class TabsNavigationWidget extends StatelessWidget {
  const TabsNavigationWidget({
    required this.tabs,
    super.key,
    this.showAppBar = true,
  });

  /// список табов
  final List<AppTabItem> tabs;

  /// показывать ли appBar
  final bool showAppBar;

  @override
  Widget build(BuildContext context) => AutoTabsRouter.tabBar(
        routes: tabs.map((e) => e.route).toList(),
        physics: const NeverScrollableScrollPhysics(),
        builder: (_, child, ctrl) => Scaffold(
          extendBodyBehindAppBar: true,
          appBar: showAppBar
              ? AppBarWidget(actions: tabs[ctrl.index].appBarActions)
              : null,
          body: Stack(
            children: [
              child,
              SafeArea(
                child: Padding(
                  padding: AppInsets.kHorizontal16,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: context.colors.mainColors.bgCard,
                      borderRadius: AppBorders.kCircular12,
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
                      padding: AppInsets.kVertical4,
                      tabs: tabs
                          .map(
                            (t) => _buildTab(
                              context,
                              icon: t.icon,
                              title: t.title,
                              isSelected: ctrl.index == tabs.indexOf(t),
                            ),
                          )
                          .toList(),
                      dividerHeight: 0,
                      splashFactory: NoSplash.splashFactory,
                      indicator: BoxDecoration(
                        borderRadius: AppBorders.kCircular8,
                        color: context.colors.mainColors.white,
                      ),
                      indicatorPadding: AppInsets.kHorizontal4,
                      indicatorSize: TabBarIndicatorSize.tab,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  /// виджет таба с иконкой и текстом
  Widget _buildTab(
    BuildContext context, {
    required String title,
    required bool isSelected,
    SvgGenImage? icon,
  }) =>
      Tab(
        child: Padding(
          padding: AppInsets.kVertical12,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              borderRadius: AppBorders.kCircular12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null)
                  Padding(
                    padding: AppInsets.kRight8,
                    child: icon.svg(
                      excludeFromSemantics: true,
                      width: AppSizes.kIconMedium,
                      height: AppSizes.kIconMedium,
                      colorFilter: ColorFilter.mode(
                        isSelected
                            ? context.colors.mainColors.primary
                            : context.colors.fieldBordersColors.main,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                Text(
                  title,
                  style: context.textStyle.textTypo.tx2SemiBold
                      .withColor(context.colors.textColors.main),
                ),
              ],
            ),
          ),
        ),
      );
}
