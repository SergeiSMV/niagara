import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Виджет нижней навигации для переключения между экранами
/// приложения в [AutoTabsScaffold].
class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({
    required this.tabsRouter,
    this.fullScreenTabs,
    super.key,
  });

  final TabsRouter tabsRouter;
  final Map<int, PageRouteInfo>? fullScreenTabs;

  $AssetsIconsBottomBarGen get _bottomIcons => Assets.icons.bottomBar;

  List<_BottomNavigationBarItem> get _items => [
        _BottomNavigationBarItem(
          title: t.routes.home,
          inactiveIcon: _bottomIcons.homeStroke,
          activeIcon: _bottomIcons.homeFilled,
        ),
        _BottomNavigationBarItem(
          title: t.routes.catalog,
          inactiveIcon: _bottomIcons.catalogStroke,
          activeIcon: _bottomIcons.catalogFilled,
        ),
        _BottomNavigationBarItem(
          title: t.routes.cart,
          inactiveIcon: _bottomIcons.cartStroke,
          activeIcon: _bottomIcons.cartFilled,
        ),
        _BottomNavigationBarItem(
          title: t.routes.shops,
          inactiveIcon: _bottomIcons.shopStroke,
          activeIcon: _bottomIcons.shopFilled,
        ),
        _BottomNavigationBarItem(
          title: t.routes.profile,
          inactiveIcon: _bottomIcons.profileStroke,
          activeIcon: _bottomIcons.profileFilled,
        ),
      ];

  BottomNavigationBarItem _buildItem(
    _BottomNavigationBarItem item,
  ) =>
      BottomNavigationBarItem(
        icon: _NavBarIconWidget(item.inactiveIcon, inactive: true),
        activeIcon: _NavBarIconWidget(item.activeIcon),
        label: item.title,
        tooltip: item.title,
      );

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(AppSizes.kGeneral16),
        topRight: Radius.circular(AppSizes.kGeneral16),
      ),
      child: BottomNavigationBar(
        currentIndex: tabsRouter.activeIndex,
        onTap: (index) {
          if (fullScreenTabs?.containsKey(index) ?? false) {
            context.pushRoute(fullScreenTabs![index]!);
            return;
          }

          tabsRouter.setActiveIndex(index);
        },
        items: _items.map(_buildItem).toList(),
      ),
    );
  }
}

/// Виджет иконки нижней навигации
class _NavBarIconWidget extends StatelessWidget {
  const _NavBarIconWidget(
    this.icon, {
    this.inactive = false,
  });

  final SvgGenImage icon;
  final bool inactive;

  @override
  Widget build(BuildContext context) {
    final unselectedColor =
        context.theme.bottomNavigationBarTheme.unselectedItemColor;
    return Padding(
      padding: AppInsets.kOnlyTop8 + AppInsets.kOnlyBottom4,
      child: icon.svg(
        width: AppSizes.kIconLarge,
        height: AppSizes.kIconLarge,
        colorFilter: inactive && unselectedColor != null
            ? ColorFilter.mode(unselectedColor, BlendMode.srcIn)
            : null,
      ),
    );
  }
}

/// Класс элемента нижней навигации
class _BottomNavigationBarItem {
  const _BottomNavigationBarItem({
    required this.title,
    required this.inactiveIcon,
    required this.activeIcon,
  });
  final String title;
  final SvgGenImage inactiveIcon;
  final SvgGenImage activeIcon;
}
