import '../../../../core/core.dart';

/// Модель для отображения опции оценки заказа
class OrderRateOption extends Equatable {
  const OrderRateOption({
    required this.id,
    required this.name,
    this.isSelected = false,
  });

  /// Идентификатор опции
  final String id;

  /// Название опции
  final String name;

  /// Флаг выбранности опции
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
  }) =>
      OrderRateOption(
        id: id ?? this.id,
        name: name ?? this.name,
        isSelected: isSelected ?? this.isSelected,
      );
}
