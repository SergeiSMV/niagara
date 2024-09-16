import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:niagara_app/core/common/domain/models/pagination.dart';
import 'package:niagara_app/core/utils/enums/product_type.dart';

/// Список продуктов с пагинацией.
typedef Products = ({List<Product> products, Pagination pagination});

/// Продукт.
///
/// Может быть обычным товаром, предоплатной водой или услугой. Подробнее в
/// [ProductType].
class Product extends Equatable {
  const Product({
    required this.id,
    required this.name,
    required this.article,
    required this.imageUrl,
    required this.description,
    required this.descriptionFull,
    required this.groupId,
    required this.groupName,
    required this.type,
    required this.price,
    required this.priceOld,
    required this.priceVip,
    required this.main,
    required this.productTara,
    required this.additionalImages,
    required this.properties,
    required this.label,
    required this.labelColor,
    required this.discountOfCount,
    required this.bonus,
    required this.complectId,
    this.count,
  });

  /// `ID` продукта.
  final String id;

  /// `ID` набора, к которому относится продукт.
  ///
  /// Есть только у [ProductType.complect].
  final String? complectId;

  /// Наименование продукта.
  final String name;

  /// Артикул продукта.
  final String article;

  /// Ссылка на изображение продукта.
  final String imageUrl;

  /// Краткое описание продукта.
  final String description;

  /// Полное описание продукта.
  final String descriptionFull;

  /// `ID` категории, к которой относится продукт.
  final String groupId;

  /// Наименование категории, к которой относится продукт.
  final String groupName;

  /// Тип продукта.
  final ProductType type;

  /// Цена продукта.
  final int price;

  /// Старая цена продукта.
  ///
  /// Зачеркивается в каталоге.
  final int priceOld;

  /// Цена продукта для `VIP`-клиентов.
  final int priceVip;

  /// Является ли продукт "основным".
  ///
  /// Если `true`, ограничения по минимальное сумме заказа не действуют.
  final bool main;

  /// Содержится ли продукт в таре.
  ///
  /// Если `true`, должна быть доступна опция "вернуть тару".
  final bool productTara;

  /// Дополнительные изображения продукта.
  final List<String> additionalImages;

  /// Набор свойств продукта.
  final List<ProductProperty> properties;

  /// Текст стикера на картинке карточки продукта.
  final String label;

  /// Цвет стикера на картинке карточки продукта.
  final Color labelColor;

  /// Информация о том, как меняется количество бонусов, поллучаемых за покупку,
  /// в зависимости от количества купленного товара.
  final String discountOfCount;

  /// Количество бонусов, получаемых за покупку.
  final int bonus;

  /// Количество товара в корзине.
  ///
  /// **ВАЖНО**: не стоит полагаться на этот параметр для определения количества
  /// товара в корзине или где-либо ещё. В некоторых случаях это число относится
  /// к корзине, в других - к балансу воды, а иногда его может не быть. Перед
  /// использованием убедитесь, что [Product] получен в нужном контексте.
  final int? count;

  /// Индикатор, является ли продукт предоплатной водой.
  ///
  /// Иногда у такого товара установлен тип [ProductType.product], но есть
  /// [complectId].
  bool get isWater =>
      type == ProductType.complect || (complectId?.isNotEmpty ?? false);

  /// Индикатор, является ли продукт услугой.
  bool get isService => type == ProductType.service;

  /// Индикатор, является ли продукт товаром.
  bool get isProduct => type == ProductType.product;

  /// Индикатор наличия скидки.
  bool get hasDiscount => priceOld > 0 && price < priceOld;

  /// Индикатор наличия скидки для `VIP`-клиентов.
  bool get hasVIPDiscount => priceVip > 0 && priceVip < price;

  // Сокращение количества логов.
  @override
  String toString() => 'Product(id: $id, name: $name, price: $price)';

  @override
  List<Object?> get props => [
        id,
        name,
        article,
        imageUrl,
        description,
        descriptionFull,
        groupId,
        groupName,
        type,
        price,
        priceOld,
        priceVip,
        main,
        productTara,
        additionalImages,
        properties,
        label,
        labelColor,
        discountOfCount,
        bonus,
        count,
      ];
}

/// Свойство продукта.
class ProductProperty extends Equatable {
  const ProductProperty({
    required this.id,
    required this.name,
    required this.value,
  });

  /// `ID` свойства.
  final String id;

  /// Наименование свойства.
  final String name;

  /// Значение свойства.
  final String value;

  @override
  List<Object?> get props => [
        id,
        name,
        value,
      ];
}
