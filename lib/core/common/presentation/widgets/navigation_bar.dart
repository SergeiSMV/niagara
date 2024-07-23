import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/cart_products_indicator_widget.dart';
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
          cartIndicator: true,
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
        icon: _NavBarIconWidget(
          item.inactiveIcon,
          inactive: true,
          cartIndicator: item.cartIndicator,
        ),
        activeIcon: _NavBarIconWidget(
          item.activeIcon,
          cartIndicator: item.cartIndicator,
        ),
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

          // переход к корневому экрану если текущий индекс совпадает
          // с индексом навигационной панели
          if (tabsRouter.activeIndex == index) {
            context.router.replaceNamed(tabsRouter.stack[index].name ?? '');
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
    this.cartIndicator = false,
  });

  final SvgGenImage icon;
  final bool inactive;
  final bool cartIndicator;

  @override
  Widget build(BuildContext context) {
    final unselectedColor =
        context.theme.bottomNavigationBarTheme.unselectedItemColor;
    return Stack(
      children: [
        Center(
          child: Padding(
            padding: AppInsets.kTop8 + AppInsets.kBottom4,
            child: icon.svg(
              width: AppSizes.kIconLarge,
              height: AppSizes.kIconLarge,
              colorFilter: inactive && unselectedColor != null
                  ? ColorFilter.mode(unselectedColor, BlendMode.srcIn)
                  : null,
            ),
          ),
        ),
        if (cartIndicator) const CartProductsIndicatorWidget(),
      ],
    );
  }
}

/// Класс элемента нижней навигации
class _BottomNavigationBarItem {
  const _BottomNavigationBarItem({
    required this.title,
    required this.inactiveIcon,
    required this.activeIcon,
    this.cartIndicator = false,
  });
  final String title;
  final SvgGenImage inactiveIcon;
  final SvgGenImage activeIcon;
  final bool cartIndicator;
}
