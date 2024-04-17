import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';

/// Кастомный виджет AppBar для приложения.
class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  /// Создает экземпляр AppBarWidget.
  /// - [title] - заголовок AppBar.
  /// - [titleWidget] - виджет заголовка AppBar.
  /// - [automaticallyImplyLeading] - флаг, показывать ли кнопку назад.
  /// - [actions] - список действий AppBar.
  /// - [key] - ключ виджета.
  const AppBarWidget({
    super.key,
    this.automaticallyImplyLeading = true,
    this.title,
    this.titleWidget,
    this.actions,
  }) : assert(
          (title == null) != (titleWidget == null),
          'Only one of title or titleWidget must be non-null',
        );

  /// Заголовок AppBar.
  final String? title;

  /// Виджет заголовка AppBar.
  final Widget? titleWidget;

  /// Флаг, показывать ли кнопку назад.
  final bool automaticallyImplyLeading;

  /// Список действий AppBar.
  final List<Widget>? actions;

  /// Возвращает виджет заголовка AppBar.
  Widget? get _title => titleWidget ?? (title != null ? Text(title!) : null);

  /// Возвращает флаг, центрировать ли заголовок.
  bool get _centerTitle => title != null;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: _title,
      centerTitle: _centerTitle,
      actions: actions,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Divider(
          thickness: AppConst.kAppBarDividerThickness,
          color: context.colors.fieldBordersColors.inactive,
          height: 0,
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + AppConst.kCommon4);
}
