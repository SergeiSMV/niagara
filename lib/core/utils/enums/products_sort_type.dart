import 'package:niagara_app/core/utils/gen/strings.g.dart';

enum ProductsSortType {
  none,
  min,
  max;

  String toLocale() => switch (this) {
        ProductsSortType.none => t.catalog.byPopularity,
        ProductsSortType.min => t.catalog.inDescendingOrder,
        ProductsSortType.max => t.catalog.inAscendingOrder,
      };
}
