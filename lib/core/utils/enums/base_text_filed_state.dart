import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';

/// Состояние текстового поля и его внешний вид
enum BaseTextFieldState {
  /// Нейтральное состояние
  idle,

  /// Успешное состояние
  success,

  /// Состояние блокировки
  disabled;

  /// Расширения для работы с состоянием. 
  /// Позволяет удобно получать цвета и иконки
  
  /// Возвращает true, если состояние idle
  bool get isIdle => this == BaseTextFieldState.idle;

  /// Возвращает true, если состояние disabled
  bool get isDisabled => this == BaseTextFieldState.disabled;

  /// Возвращает true, если состояние success
  bool get isSuccess => this == BaseTextFieldState.success;

  /// Получение цвета для состояния
  Color? color(BuildContext context) => switch (this) {
        BaseTextFieldState.success => context.colors.infoColors.green,
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
