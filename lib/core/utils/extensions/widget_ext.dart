import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';

/// Расширение для [Widget] для удобного добавления отступов к виджетам
extension WidgetPaddingExt on Widget {
  /// Возвращает виджет с отступами по заданным сторонам
  Widget padding({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) =>
      Padding(
        padding: left.left + top.top + right.right + bottom.bottom,
        child: this,
      );

  /// Возвращает виджет с отступами со всех сторон
  Widget paddingAll(double padding) => Padding(
        padding: padding.all,
        child: this,
      );

  /// Возвращает виджет с отступами по горизонтали и/или вертикали
  Widget paddingSymmetric({
    double horizontal = 0,
    double vertical = 0,
  }) =>
      Padding(
        padding: horizontal.horizontal + vertical.vertical,
        child: this,
      );

  /// Возвращает виджет со всеми заданными отступами
  Widget paddingLTRB(double left, double top, double right, double bottom) =>
      Padding(
        padding: EdgeInsets.fromLTRB(left, top, right, bottom),
        child: this,
      );
}
