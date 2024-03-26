import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/enums/base_button_size.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';

/// Абстрактный класс кнопки [BaseButton]. Поддерживает состояния загрузки и
/// недоступность для нажатия. Принимает параметры:
/// - [key] - ключ виджета,
/// - [child] - виджет кнопки,
/// - [onTap] - функция, которая будет вызвана при нажатии на кнопку,
/// - [size] - размер кнопки (по умолчанию [BaseButtonSize.large]).
///
/// При отсутствии [child] кнопка будет отображать индикатор загрузки, а при
/// отсутствии [onTap] кнопка будет неактивной.
abstract class BaseButton extends StatelessWidget {
  /// Создает экземпляр [BaseButton] основного стиля.
  /// Описание параметров см. в [BaseButton].
  BaseButton.primary(
    BuildContext context, {
    super.key,
    this.child,
    this.onTap,
    this.size = BaseButtonSize.large,
  }) : buttonColor = context.colors.buttonColors.primary;

  /// Создает экземпляр [BaseButton] акцентного стиля.
  /// Описание параметров см. в [BaseButton].
  BaseButton.assent(
    BuildContext context, {
    super.key,
    this.child,
    this.onTap,
    this.size = BaseButtonSize.large,
  }) : buttonColor = context.colors.buttonColors.accent;

  /// Создает экземпляр [BaseButton] вторичного стиля.
  /// Описание параметров см. в [BaseButton].
  BaseButton.secondary(
    BuildContext context, {
    super.key,
    this.child,
    this.onTap,
    this.size = BaseButtonSize.large,
  }) : buttonColor = context.colors.buttonColors.secondary;

  /// Создает экземпляр [BaseButton] невидимого стиля.
  /// Описание параметров см. в [BaseButton].
  BaseButton.invisible(
    BuildContext context, {
    super.key,
    this.child,
    this.onTap,
    this.size = BaseButtonSize.large,
  }) : buttonColor = context.colors.textColors.accent;

  /// Текст кнопки
  final Widget? child;

  /// Функция, которая будет вызвана при нажатии на кнопку
  final VoidCallback? onTap;

  /// Размер кнопки
  final BaseButtonSize size;

  /// Цвет кнопки
  final Color? buttonColor;

  // Проверка состояния кнопки (загрузка, недоступность для нажатия)
  bool get _loading => child == null;
  bool get _inactive => onTap == null;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _inactive ? null : onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _inactive ? context.colors.buttonColors.inactive : buttonColor,
          borderRadius: BorderRadius.circular(size.borderRadius),
        ),
        height: size.height,
        width: double.infinity,
        child: _loading ? Assets.lottie.loadCircleWhite.lottie() : child,
      ),
    );
  }
}
