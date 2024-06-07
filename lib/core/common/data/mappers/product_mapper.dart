import 'package:drift/drift.dart';
import 'package:niagara_app/core/common/data/database/app_database.dart';
import 'package:niagara_app/core/common/data/local/entities/product_entity.dart';
import 'package:niagara_app/core/common/data/remote/dto/product_dto.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/utils/extensions/color_ext.dart';

extension ProductDtoMapper on ProductDto {
  Product toModel() => Product(
        id: productId ?? '',
        name: productName ?? '',
        article: productArticle ?? '',
        imageUrl: productImage ?? '',
        description: productDescription ?? '',
        descriptionFull: productDescriptionFull ?? '',
        groupId: productGroupId ?? '',
        groupName: productGroupName ?? '',
        type: productType ?? '',
        price: productPrice ?? 0,
        priceOld: productPriceOld ?? 0,
        priceVip: productPriceVip ?? 0,
        main: productMain ?? false,
        productTara: productTara ?? false,
        additionalImages: imagesArray ?? [],
        properties: propertyArray?.map((e) => e.toModel()).toList() ?? [],
        label: label ?? '',
        labelColor: HexColor.fromHex(labelColor ?? ''),
        discountOfCount: discountOfCount ?? '',
        bonus: bonus ?? 0,
      );
}

extension PropertyMapper on PropertyArrayDto {
  ProductProperty toModel() => ProductProperty(
        id: propertyId ?? '',
        name: propertyName ?? '',
        value: propertyValue ?? '',
      );
}

extension ProductTableMapper on FavoritesTableData {
  ProductEntity toEntity() => ProductEntity(
        id: id,
        name: name,
        article: article,
        imageUrl: imageUrl,
        description: description,
        descriptionFull: descriptionFull,
        groupId: groupId,
        groupName: groupName,
        type: type,
        price: price,
        priceOld: priceOld,
        priceVip: priceVip,
        main: main,
        productTara: productTara,
        additionalImages: additionalImages,
        properties: properties,
        label: label,
        labelColor: HexColor.fromHex(labelColor),
        discountOfCount: discountOfCount,
        bonus: bonus,
      );
}

extension FavoritesEntityMapper on ProductEntity {
  FavoritesTableCompanion toCompanion() => FavoritesTableCompanion(
        id: Value(id),
        name: Value(name),
        article: Value(article),
        imageUrl: Value(imageUrl),
        description: Value(description),
        descriptionFull: Value(descriptionFull),
        groupId: Value(groupId),
        groupName: Value(groupName),
        type: Value(type),
        price: Value(price),
        priceOld: Value(priceOld),
        priceVip: Value(priceVip),
        main: Value(main),
        productTara: Value(productTara),
        additionalImages: Value(additionalImages),
        properties: Value(properties),
        label: Value(label),
        labelColor: Value(HexColor.toHex(labelColor)),
        discountOfCount: Value(discountOfCount),
        bonus: Value(bonus),
      );

  Product toModel() => Product(
        id: id,
        name: name,
        article: article,
        imageUrl: imageUrl,
        description: description,
        descriptionFull: descriptionFull,
        groupId: groupId,
        groupName: groupName,
        type: type,
        price: price,
        priceOld: priceOld,
        priceVip: priceVip,
        main: main,
        productTara: productTara,
        additionalImages: additionalImages,
        properties: properties.map((e) => e.toModel()).toList(),
        label: label,
        labelColor: labelColor,
        discountOfCount: discountOfCount,
        bonus: bonus,
      );
}

extension ProductMapper on Product {
  ProductEntity toEntity() => ProductEntity(
        id: id,
        name: name,
        article: article,
        imageUrl: imageUrl,
        description: description,
        descriptionFull: descriptionFull,
        groupId: groupId,
        groupName: groupName,
        type: type,
        price: price,
        priceOld: priceOld,
        priceVip: priceVip,
        main: main,
        productTara: productTara,
        additionalImages: additionalImages,
        properties: properties.map((e) => e.toEntity()).toList(),
        label: label,
        labelColor: labelColor,
        discountOfCount: discountOfCount,
        bonus: bonus,
      );
}

extension ProductPropertyMapper on ProductProperty {
  ProductPropertyEntity toEntity() => ProductPropertyEntity(
        id: id,
        name: name,
        value: value,
      );
}

extension ProductPropertyEntityMapper on ProductPropertyEntity {
  ProductProperty toModel() => ProductProperty(
        id: id,
        name: name,
        value: value,
      );
}
