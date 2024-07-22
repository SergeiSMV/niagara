import 'package:niagara_app/core/core.dart';

class OrderRateOption extends Equatable {
  const OrderRateOption({
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

  OrderRateOption copyWith({
    String? id,
    String? name,
    bool? isSelected,
  }) {
    return OrderRateOption(
      id: id ?? this.id,
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
