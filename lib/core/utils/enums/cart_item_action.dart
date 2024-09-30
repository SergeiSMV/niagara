import 'package:niagara_app/core/utils/gen/assets.gen.dart';

/// Действие над товаром в корзине.
///
/// `plus` - увеличить количество товара в корзине.
/// `minus` - уменьшить количество товара в корзине.
enum ItemAction {
  plus,
  minus;

  /// Проверка на действие увеличения количества товара.
  bool get isPlus => this == ItemAction.plus;

  /// Иконка действия.
  SvgGenImage get icon =>
      this == ItemAction.plus ? Assets.icons.plus : Assets.icons.minus;
}
