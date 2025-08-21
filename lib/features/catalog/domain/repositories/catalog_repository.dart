import '../../../../core/common/domain/models/product.dart';
import '../../../../core/core.dart';
import '../../../../core/utils/enums/products_sort_type.dart';
import '../model/filter.dart';
import '../model/group.dart';

/// Интерфейс для работы с каталогом
abstract interface class ICatalogRepository {
  /// Получает список групп товаров
  Future<Either<Failure, List<Group>>> getGroups();

  /// Получает список товаров указанной группы
  Future<Either<Failure, Products>> getCategory({
    required Group group,
    required int page,
    required ProductsSortType sort,
    List<String>? filtersIDs,
    String? promotionId,
  });

  /// Получает список рекомендованных товаров
  Future<Either<Failure, List<Product>>> getRecommends({
    required Product product,
  });

  /// Получает список фильтров для указанной группы
  Future<Either<Failure, List<Filter>>> getFilters({
    required Group group,
  });

  /// Получает список товаров по поисковому запросу
  Future<Either<Failure, Products>> getProductsBySearch({
    required String text,
    required int page,
    required ProductsSortType sort,
  });

  /// Получает товар по id
  ///
  /// [productId] - идентификатор товара
  Future<Either<Failure, Product>> getProductById({
    required String productId,
  });
}
