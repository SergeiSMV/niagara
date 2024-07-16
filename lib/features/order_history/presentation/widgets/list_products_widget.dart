import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/features/order_history/presentation/widgets/product_item_widget.dart';

class ListProductsWidget extends StatelessWidget {
  const ListProductsWidget({
    super.key,
    required this.products,
  });

  final List<Product> products;

  // Метод для получения списка уникальных продуктов и их количества
  List<(int, Product)> getUniqueProducts() {
    // Создаем Map для хранения количества одинаковых товаров
    final productCounts = <Product, int>{};

    // Проходим по списку товаров
    for (final product in products) {
      // Если товар уже есть в productCounts, увеличиваем его количество
      if (productCounts.containsKey(product)) {
        productCounts[product] = productCounts[product]! + 1;
      } else {
        // Иначе добавляем товар в productCounts с количеством 1
        productCounts[product] = 1;
      }
    }

    // Создаем список кортежей (количество, товар)
    final productCountsList = <(int, Product)>[];

    // Добавляем кортежи в список
    productCounts.forEach((product, count) {
      productCountsList.add((count, product));
    });

    // Возвращаем список кортежей
    return productCountsList;
  }

  @override
  Widget build(BuildContext context) {
    final productCountsList = getUniqueProducts();

    return SliverPadding(
      padding: AppInsets.kHorizontal16,
      sliver: SliverList.separated(
        itemCount: productCountsList.length,
        itemBuilder: (context, index) => ProductItemWidget(
          product: productCountsList[index].$2,
          productCount: productCountsList[index].$1,
        ),
        separatorBuilder: (_, __) => AppBoxes.kHeight8,
      ),
    );
  }
}
