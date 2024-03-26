import 'package:flutter/widgets.dart';

/// Расширение для [TextStyle] для удобного изменения цвета текста.
extension TextStyleExt on TextStyle {
  /// Метод для изменения цвета текста.
  TextStyle withColor(Color color) => copyWith(color: color);
}
