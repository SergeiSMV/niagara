import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

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
    this.count,
  });

  final String id;
  final String name;
  final String article;
  final String imageUrl;
  final String description;
  final String descriptionFull;
  final String groupId;
  final String groupName;
  final String type;
  final int price;
  final int priceOld;
  final int priceVip;
  final bool main;
  final bool productTara;
  final List<String> additionalImages;
  final List<ProductProperty> properties;
  final String label;
  final Color labelColor;
  final String discountOfCount;
  final int bonus;
  final int? count;

  bool get hasDiscount => priceOld > 0 && price < priceOld;

  bool get hasVIPDiscount => priceVip > 0 && priceVip < price;

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

class ProductProperty extends Equatable {
  const ProductProperty({
    required this.id,
    required this.name,
    required this.value,
  });

  final String id;
  final String name;
  final String value;

  @override
  List<Object?> get props => [
        id,
        name,
        value,
      ];
}
