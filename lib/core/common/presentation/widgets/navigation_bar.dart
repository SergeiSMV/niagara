import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Виджет нижней навигации для переключения между экранами
/// приложения в [AutoTabsScaffold].
class BottomNavigationBarWidget extends StatelessWidget {
  /// Конструктор виджета нижней навигации.
  /// Принимает [TabsRouter] для работы с навигацией между экранами.
  const BottomNavigationBarWidget({
    required this.tabsRouter,
    super.key,
  });

  /// Роутер для переключения между экранами
  final TabsRouter tabsRouter;

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
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppConst.kNavBarRadius),
          topRight: Radius.circular(AppConst.kNavBarRadius),
        ),
        child: BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: _items.map(_buildItem).toList(),
        ),
      );
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
      padding: (AppConst.kNavBarIconPadding * 2).top +
          AppConst.kNavBarIconPadding.bottom,
      child: icon.svg(
        width: AppConst.kNavBarIconSize,
        height: AppConst.kNavBarIconSize,
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
