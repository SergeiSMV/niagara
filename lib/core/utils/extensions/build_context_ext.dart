import 'package:flutter/material.dart';
import 'package:niagara_app/core/theme/colors/base_colors.dart';
import 'package:niagara_app/core/theme/typography/base_typography.dart';

/// Расширение для [BuildContext] для удобного доступа к вспомогательным методам
/// и свойствам. Все методы и свойства возвращаются через контекст для
/// использования в виджетах.
extension BuildContextExt on BuildContext {
  MediaQueryData get _mediaQuery => MediaQuery.of(this);

  /// Возвращает тему приложения.
  ThemeData get theme => Theme.of(this);

  /// Возвращает типографику приложения.
  BaseTypography get textStyle => theme.extension<BaseTypography>()!;

  /// Возвращает цветовую тему приложения.
  BaseColors get colors => theme.extension<BaseColors>()!;

  /// Вернуть размер экрана
  Size get screenSize => _mediaQuery.size;

  /// Вернуть ширину экрана
  double get screenWidth => screenSize.width;

  /// Вернуть высоту экрана
  double get screenHeight => screenSize.height;

  /// Вернуть ориентацию экрана
  Orientation get orientation => _mediaQuery.orientation;
}
