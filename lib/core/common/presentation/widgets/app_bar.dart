import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';

/// Кастомный виджет AppBar для приложения.
class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
    this.automaticallyImplyLeading = true,
    this.automaticallyImplyTitle = true,
    this.title,
    this.body,
    this.actions,
  });

  /// Заголовок AppBar.
  final String? title;

  /// Виджет вместо заголовка AppBar.
  final Widget? body;

  /// Флаг, показывать ли кнопку назад.
  final bool automaticallyImplyLeading;

  /// Флаг, показывать ли заголовок у текущего экрана.
  final bool automaticallyImplyTitle;

  /// Виджеты справа от заголовка.
  final List<Widget>? actions;

  bool get _showTitle => title != null || automaticallyImplyTitle;

  bool get _centerTitle => _showTitle;

  @override
  Widget build(BuildContext context) {
    final title = Text(this.title ?? context.topRoute.title(context));

    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: automaticallyImplyLeading
          ? AutoLeadingButton(color: context.colors.mainColors.white)
          : null,
      title: body ?? (_showTitle ? title : null),
      centerTitle: _centerTitle,
      titleTextStyle: context.textStyle.textTypo.tx1SemiBold
          .withColor(context.colors.textColors.main),
      actions: actions,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(AppConst.kCommon0),
        child: Divider(
          thickness: AppConst.kCommon1,
          color: context.colors.fieldBordersColors.inactive,
          height: AppConst.kCommon0,
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + AppConst.kCommon4);
}
