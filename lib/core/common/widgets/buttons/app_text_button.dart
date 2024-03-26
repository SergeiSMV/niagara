import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/widgets/buttons/base_button.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/enums/base_button_size.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/padding_widget_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';

/// Кнопка с текстом [AppTextButton]. Поддерживает различные стили.
/// Поддерживает состояния загрузки и недоступность для нажатия.
class AppTextButton extends BaseButton {
  /// Создает экземпляр [AppTextButton] основного стиля.
  /// Описание параметров см. в [BaseButton].
  AppTextButton.primary(
    super.context, {
    super.key,
    this.text,
    super.onTap,
    super.size = BaseButtonSize.large,
  }) : super.primary(
          child: Text(
            text ?? '',
            style: context.textStyle.buttonTypo.btn1b
                .withColor(context.colors.textColors.white),
          ),
        );

  /// Создает экземпляр [AppTextButton] акцентного стиля.
  /// Описание параметров см. в [BaseButton].
  AppTextButton.assent(
    super.context, {
    super.key,
    this.text,
    super.onTap,
    super.size = BaseButtonSize.large,
  }) : super.assent(
          child: _buildText(
            context,
            text: text ?? '',
            style: context.textStyle.buttonTypo.btn1b
                .withColor(context.colors.textColors.white),
            size: size,
          ),
        );

  /// Создает экземпляр [AppTextButton] вторичного стиля.
  /// Описание параметров см. в [BaseButton].
  AppTextButton.secondary(
    super.context, {
    super.key,
    this.text,
    super.onTap,
    super.size = BaseButtonSize.large,
  }) : super.secondary(
          child: _buildText(
            context,
            text: text ?? '',
            style: context.textStyle.buttonTypo.btn1sb
                .withColor(context.colors.textColors.main),
            size: size,
          ),
        );

  /// Создает экземпляр [AppTextButton] невидимого стиля.
  /// Описание параметров см. в [BaseButton].
  AppTextButton.invisible(
    super.context, {
    super.key,
    this.text,
    super.onTap,
    super.size,
  }) : super.invisible(
          child: _buildText(
            context,
            text: text ?? '',
            style: context.textStyle.buttonTypo.btn1sb
                .withColor(context.colors.textColors.accent),
            size: size,
          ),
        );

  /// Создает виджет [Text] с указанным текстом и стилем с учетом размера кнопки
  static Widget _buildText(
    BuildContext context, {
    required String text,
    required TextStyle style,
    required BaseButtonSize size,
  }) =>
      Text(text, style: style).paddingSymmetric(
        vertical: size.verticalPadding,
        horizontal: AppConst.kButtonHorizontalPadding,
      );

  /// Текст кнопки
  final String? text;
}
