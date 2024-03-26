import 'package:flutter/widgets.dart';

/// Расширение для [num] для удобного создания пространства
extension SizedExt on num {
  /// Возвращает [SizedBox]-виджет пространства с заданной высотой
  Widget get height => SizedBox(height: toDouble());

  /// Возвращает [SizedBox]-виджет пространства с заданной шириной
  Widget get width => SizedBox(width: toDouble());
}
