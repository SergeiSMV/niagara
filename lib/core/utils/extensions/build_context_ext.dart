import 'package:flutter/material.dart';
import '../../common/presentation/theme/colors/base_colors.dart';
import '../../common/presentation/theme/typography/base_typography.dart';

/// Расширение для [BuildContext] для удобного доступа к вспомогательным методам
/// и свойствам. Все методы и свойства возвращаются через контекст для
/// использования в виджетах.
extension BuildContextExt on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  ThemeData get theme => Theme.of(this);

  BaseTypography get textStyle {
    final typography = theme.extension<BaseTypography>();
    if (typography == null) {
      throw FlutterError(
        'BaseTypography extension not found in ThemeData. '
        'Make sure to add it during ThemeData creation.',
      );
    }
    return typography;
  }

  BaseColors get colors {
    final colors = theme.extension<BaseColors>();
    if (colors == null) {
      throw FlutterError(
        'BaseColors extension not found in ThemeData. '
        'Make sure to add it during ThemeData creation.',
      );
    }
    return colors;
  }

  Size get screenSize => mediaQuery.size;

  double get devicePixelRatio => mediaQuery.devicePixelRatio;

  double get screenWidth => screenSize.width;

  double get screenHeight => screenSize.height;

  Orientation get orientation => mediaQuery.orientation;
}
