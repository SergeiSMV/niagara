import 'package:flutter/material.dart';

/// Расширение для [Widget] для удобного добавления отступов к виджетам
extension PaddingWidgetExt on Widget {
  /// Возвращает виджет с отступами по заданным сторонам
  Widget padding({
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) =>
      Padding(
        padding: EdgeInsets.only(
          left: left ?? 0,
          top: top ?? 0,
          right: right ?? 0,
          bottom: bottom ?? 0,
        ),
        child: this,
      );

  /// Возвращает виджет с отступами со всех сторон
  Widget paddingAll(double padding) => Padding(
        padding: EdgeInsets.all(padding),
        child: this,
      );

  /// Возвращает виджет с отступами по горизонтали и/или вертикали
  Widget paddingSymmetric({
    double horizontal = 0,
    double vertical = 0,
  }) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: this,
      );

  /// Возвращает виджет со всеми заданными отступами
  Widget paddingLTRB(double left, double top, double right, double bottom) =>
      Padding(
        padding: EdgeInsets.fromLTRB(left, top, right, bottom),
        child: this,
      );
}
