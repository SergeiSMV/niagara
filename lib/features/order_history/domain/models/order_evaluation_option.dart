import 'package:niagara_app/core/core.dart';

class OrderEvaluationOption extends Equatable {
  const OrderEvaluationOption({
    required this.id,
    required this.name,
    this.isSelected = false,
  });

  final String id;
  final String name;
  final bool isSelected;

  @override
  List<Object?> get props => [
        id,
        name,
        isSelected,
      ];

  OrderEvaluationOption copyWith({
    String? id,
    String? name,
    bool? isSelected,
  }) {
    return OrderEvaluationOption(
      id: id ?? this.id,
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
