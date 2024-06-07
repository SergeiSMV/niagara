import 'package:niagara_app/core/core.dart';

class Filter extends Equatable {
  const Filter({
    required this.id,
    required this.name,
    required this.properties,
  });

  final String id;
  final String name;
  final List<FilterProperty> properties;

  @override
  List<Object?> get props => [id, name, properties];
}

class FilterProperty extends Equatable {
  const FilterProperty({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}
