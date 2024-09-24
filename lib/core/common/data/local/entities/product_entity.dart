// ignore_for_file: sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_entity.g.dart';

@JsonSerializable()
class ProductEntity extends Equatable {
  const ProductEntity({
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

  final String id;
  final String? complectId;
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
  final List<ProductPropertyEntity> properties;
  final String label;
  @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
  final Color labelColor;
  final String discountOfCount;
  final int bonus;
  final int? count;

  factory ProductEntity.fromJson(Map<String, dynamic> json) =>
      _$ProductEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ProductEntityToJson(this);

  static Color colorFromJson(int colorValue) => Color(colorValue);

  static int colorToJson(Color color) => color.value;

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

@JsonSerializable()
class ProductPropertyEntity extends Equatable {
  const ProductPropertyEntity({
    required this.id,
    required this.name,
    required this.value,
  });

  final String id;
  final String name;
  final String value;

  factory ProductPropertyEntity.fromJson(Map<String, dynamic> json) =>
      _$ProductPropertyEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ProductPropertyEntityToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        value,
      ];
}
