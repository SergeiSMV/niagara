import 'package:niagara_app/core/core.dart';

/// Информация о заказе на пополнение счета воды.
class PrepaidWaterOrderData extends Equatable {
  const PrepaidWaterOrderData({required this.complectId, required this.count});

  /// `ID` комплекта (`ID` товарной позиции с типом [ProductType.complect]).
  final String complectId;

  /// Количество тар воды.
  final int count;

  @override
  List<Object?> get props => [complectId, count];
}
