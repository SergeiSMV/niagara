import 'package:niagara_app/core/common/data/remote/dto/product_dto.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/utils/extensions/color_ext.dart';

extension ProductMapper on ProductDto {
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
