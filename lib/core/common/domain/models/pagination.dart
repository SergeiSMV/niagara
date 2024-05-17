import 'package:niagara_app/core/core.dart';

@Equatable()
class Pagination {
  Pagination({
    required this.current,
    required this.total,
  });

  final int current;
  final int total;
}
