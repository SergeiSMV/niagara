import 'package:niagara_app/core/core.dart';

class Pagination extends Equatable {
  const Pagination({
    required this.current,
    required this.total,
  });

  final int current;
  final int total;

  @override
  List<Object?> get props => [current, total];
}
