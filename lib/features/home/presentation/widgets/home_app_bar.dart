import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/home/presentation/widgets/action_button.dart';
import 'package:niagara_app/features/home/presentation/widgets/address_button.dart';

/// Верхняя панель главной страницы. Создает виджет верхней панели главной
/// страницы с адресом доставки и кнопками действий (уведомления и поддержка).
class HomeAppBar extends StatelessWidget {
  /// Создает виджет верхней панели главной страницы.
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      title: const AppBarAddressButton(),
      actions: [
        AppBarActionButton(
          icon: Assets.icons.notifications,
          // TODO(Oleg): Реализовать переход на экран уведомлений
          onTap: () => debugPrint('Notifications'),
        ),
        AppBarActionButton(
          icon: Assets.icons.support,
          // TODO(Oleg): Реализовать переход на экран поддержки
          onTap: () => debugPrint('Support'),
        ),
        AppConst.kPaddingMid.width,
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Divider(
          thickness: AppConst.kAppBarDividerThickness,
          color: context.colors.fieldBordersColors.inactive,
        ),
      ),
    );
  }
}
