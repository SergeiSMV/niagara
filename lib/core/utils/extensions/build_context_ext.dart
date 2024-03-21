import 'package:flutter/material.dart';
import 'package:niagara_app/config/theme/app_colors.dart';
import 'package:niagara_app/config/theme/app_typo.dart';

/// Расширение для [BuildContext] для удобного доступа к вспомогательным методам
/// и свойствам. Все методы и свойства возвращаются через контекст для
/// использования в виджетах.
extension BuildContextExt on BuildContext {
  ThemeData get _theme => Theme.of(this);
  MediaQueryData get _mediaQuery => MediaQuery.of(this);

  /// Возвращает типографику приложения.
  AppTypo get textStyle => _theme.extension<AppTypo>()!;

  /// Возвращает цветовую тему приложения.
  AppColors get colors => _theme.extension<AppColors>()!;

  /// Вернуть размер экрана
  Size get screenSize => _mediaQuery.size;

  /// Вернуть ширину экрана
  double get screenWidth => screenSize.width;

  /// Вернуть высоту экрана
  double get screenHeight => screenSize.height;

  /// Вернуть ориентацию экрана
  Orientation get orientation => _mediaQuery.orientation;
}
