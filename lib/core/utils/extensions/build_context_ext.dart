import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/theme/colors/base_colors.dart';
import 'package:niagara_app/core/common/presentation/theme/typography/base_typography.dart';

/// Расширение для [BuildContext] для удобного доступа к вспомогательным методам
/// и свойствам. Все методы и свойства возвращаются через контекст для
/// использования в виджетах.
extension BuildContextExt on BuildContext {
  MediaQueryData get _mediaQuery => MediaQuery.of(this);

  ThemeData get theme => Theme.of(this);

  BaseTypography get textStyle => theme.extension<BaseTypography>()!;

  BaseColors get colors => theme.extension<BaseColors>()!;

  Size get screenSize => _mediaQuery.size;

  double get devicePixelRatio => _mediaQuery.devicePixelRatio;

  double get screenWidth => screenSize.width;

  double get screenHeight => screenSize.height;

  Orientation get orientation => _mediaQuery.orientation;
}
