/// Тип удаления, указывающий какие именно товары нужно удалить из корзины
/// (доступные к заказу / недоступные к заказу)
enum CartClearTypes {
  /// Товары доступные к заказу
  inStock,

  /// Товары недоступные к заказу
  outOfStock;

  String typeToString() => switch (this) {
        inStock => 'in_stock',
        outOfStock => 'out_of_stock',
      };
}
