import '../../../core/common/domain/models/product.dart';
import '../../../core/core.dart';
import '../../../core/utils/enums/products_sort_type.dart';
import '../../catalog/domain/repositories/catalog_repository.dart';

/// Usecase для получения товара по id
@singleton
class ProductByIdUsecase {
  ProductByIdUsecase(this.catalogRepository);

  /// Репозиторий для работы с каталогом
  final ICatalogRepository catalogRepository;

  Future<Product?> call(String productId, String productName) async {
    // Попробуем найти товар по названию
    final result = await catalogRepository.getProductsBySearch(
      text: productName,
      page: 1,
      sort: ProductsSortType.none,
    );

    return result.fold(
      (failure) => null,
      (products) async {
        // Выводим все найденные товары для отладки
        for (final product in products.products) {
          if (product.id == productId) {
            return product;
          }
        }

        // Если не найден по ID, попробуем найти по ключевым словам
        final keywords = extractKeywords(productName);

        // Ищем товар по каждому ключевому слову отдельно
        for (final keyword in keywords) {
          final keywordProduct = await _searchByKeyword(keyword, productId);
          if (keywordProduct != null) {
            return keywordProduct;
          }
        }
        return null;
      },
    );
  }

  /// Поиск товара по ключевому слову
  Future<Product?> _searchByKeyword(String keyword, String productId) async {
    final keywordResult = await catalogRepository.getProductsBySearch(
      text: keyword,
      page: 1,
      sort: ProductsSortType.none,
    );

    return keywordResult.fold(
      (failure) => null,
      (keywordProducts) {
        // Ищем товар по ID в результатах поиска по ключевому слову
        for (final product in keywordProducts.products) {
          if (product.id == productId) {
            return product;
          }
        }
        return null;
      },
    );
  }
}

/// Извлекает ключевые слова из названия товара для поиска
List<String> extractKeywords(String productName) {
  final keywords = <String>[];

  // Убираем специальные символы и цифры
  final cleanName = productName
      .replaceAll(RegExp(r'[0-9,\.\-\+\s]+'), ' ')
      .trim()
      .toLowerCase();

  // Разбиваем на слова
  final words = cleanName.split(' ').where((word) => word.length > 2).toList();

  // Добавляем оригинальные слова (без очистки)
  final originalWords =
      productName.split(' ').where((word) => word.length > 2).toList();

  keywords
    ..addAll(words)
    ..addAll(originalWords);

  // Убираем дубликаты
  return keywords.toSet().toList();
}
