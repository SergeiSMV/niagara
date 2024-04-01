import 'package:flutter/widgets.dart';

/// Расширение для [num] для удобного создания пространства
extension SizedBoxExt on num {
  /// Возвращает [SizedBox]-виджет пространства с заданной высотой
  Widget get height => SizedBox(height: toDouble());

  /// Возвращает [SizedBox]-виджет пространства с заданной шириной
  Widget get width => SizedBox(width: toDouble());
}

/// Расширение для [num] для удобного создания отступов
extension EdgeInsetsExt on num {
  /// Отступ со всех сторон
  EdgeInsets get all => EdgeInsets.all(toDouble());

  /// Отступы слева и справа
  EdgeInsets get horizontal => EdgeInsets.symmetric(horizontal: toDouble());

  /// Отступы сверху и снизу
  EdgeInsets get vertical => EdgeInsets.symmetric(vertical: toDouble());

  /// Отступ сверху
  EdgeInsets get top => EdgeInsets.only(top: toDouble());

  /// Отступ снизу
  EdgeInsets get bottom => EdgeInsets.only(bottom: toDouble());

  /// Отступ слева
  EdgeInsets get left => EdgeInsets.only(left: toDouble());

  /// Отступ справа
  EdgeInsets get right => EdgeInsets.only(right: toDouble());
}
