// ignore_for_file: sort_constructors_first

/// Тип продукта.
enum ProductType {
  /// Товар.
  product,

  /// Набор предоплатной воды.
  complect,

  // TODO(kvbykov): Чистка оборудования?
  /// Услуга.
  service;

  /// Преобразует строковое значение в тип продукта.
  factory ProductType.fromString(String value) {
    switch (value.toLowerCase()) {
      case 'product':
        return ProductType.product;
      case 'complect':
        return ProductType.complect;
      case 'service':
        return ProductType.service;
      default:
        throw ArgumentError('Unknown product type: $value');
    }
  }

  @override
  String toString() {
    switch (this) {
      case ProductType.product:
        return 'product';
      case ProductType.complect:
        return 'complect';
      case ProductType.service:
        return 'service';
    }
  }
}
