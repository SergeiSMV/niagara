import 'package:niagara_app/core/common/domain/models/pagination.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/products_sort_type.dart';
import 'package:niagara_app/features/catalog/domain/model/filter.dart';
import 'package:niagara_app/features/catalog/domain/model/group.dart';

typedef Products = ({List<Product> products, Pagination pagination});

abstract interface class ICatalogRepository {
  Future<Either<Failure, List<Group>>> getGroups();

  Future<Either<Failure, Products>> getCategory({
    required Group group,
    required int page,
    required ProductsSortType sort,
    List<String>? filtersIDs,
  });

  Future<Either<Failure, List<Product>>> getRecommends({
    required Product product,
  });

  Future<Either<Failure, List<Filter>>> getFilters({
    required Group group,
  });

  Future<Either<Failure, List<Product>>> getProductsBySearch({
    required String text,
  });
}
