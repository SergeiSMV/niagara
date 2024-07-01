import 'package:niagara_app/core/core.dart';

class Pagination extends Equatable {
  const Pagination({
    required this.current,
    required this.total,
    required this.items,
  });

  final int current;
  final int total;
  final int items;

  @override
  List<Object?> get props => [
        current,
        total,
        items,
      ];
}
