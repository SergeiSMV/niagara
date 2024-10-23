// ignore_for_file: sort_constructors_first

import 'package:niagara_app/core/core.dart';

class PaginationDto extends Equatable {
  const PaginationDto({
    required this.current,
    required this.total,
    required this.items,
  });

  final int current;
  final int total;
  final int items;

  factory PaginationDto.fromJson(Map<String, dynamic> json) => PaginationDto(
        current: (json['CURRENT'] as num).toInt(),
        total: (json['TOTAL'] as num).toInt(),
        items: (json['ITEMS'] as int?) ?? 0,
      );

  @override
  List<Object?> get props => [current, total];
}
