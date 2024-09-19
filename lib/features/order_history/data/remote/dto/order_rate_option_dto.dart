// ignore_for_file: sort_constructors_first

import 'package:niagara_app/core/core.dart';

class OrderRateOptionDto extends Equatable {
  const OrderRateOptionDto({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory OrderRateOptionDto.fromJson(Map<String, dynamic> json) =>
      OrderRateOptionDto(
        id: json['ID'] as String,
        name: json['NAME'] as String,
      );

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}
