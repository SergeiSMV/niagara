import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';

/// Состояние текстового поля и его внешний вид
enum BaseTextFieldState {
  idle,

  success,

  notSuccess,

  disabled;

  bool get isIdle => this == BaseTextFieldState.idle;

  bool get isDisabled => this == BaseTextFieldState.disabled;

  bool get isSuccess => this == BaseTextFieldState.success;

  bool get isNotSuccess => this == BaseTextFieldState.notSuccess;

  /// Получение цвета для состояния
  Color? color(BuildContext context) => switch (this) {
        BaseTextFieldState.success => context.colors.infoColors.green,
        BaseTextFieldState.notSuccess => context.colors.infoColors.red,
        _ => null,
      };

  /// Получение иконки и ее цвета для состояния
  (SvgGenImage, Color)? iconWithColor(BuildContext context) => switch (this) {
        BaseTextFieldState.success => (
            Assets.icons.check,
            context.colors.infoColors.green,
          ),
        BaseTextFieldState.disabled => (
            Assets.icons.lock,
            context.colors.fieldBordersColors.main,
          ),
        _ => null,
      };
}
