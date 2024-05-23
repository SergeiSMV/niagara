import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';

class AppTabItem {
  const AppTabItem({
    required this.route,
    required this.title,
    this.icon,
  });

  final PageRouteInfo<dynamic> route;
  final String title;
  final SvgGenImage? icon;
}

class TabsNavigationWidget extends StatelessWidget {
  const TabsNavigationWidget({
    super.key,
    required this.tabs,
  });

  final List<AppTabItem> tabs;

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.tabBar(
      routes: tabs.map((e) => e.route).toList(),
      physics: const NeverScrollableScrollPhysics(),
      builder: (_, child, ctrl) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const AppBarWidget(),
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
  }

  Widget _buildTab(
    BuildContext context, {
    SvgGenImage? icon,
    required String title,
    required bool isSelected,
  }) {
    return Padding(
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
    );
  }
}
