import 'package:niagara_app/core/core.dart';

class CartPending extends Equatable {
  const CartPending({
    this.productId,
    required this.count,
    required this.type,
  });

  /// `ID` продукта, с которым связано действие.
  final String? productId;

  // Ожидаемое колтичество товара, которое будет достигнуто после выполнения
  // действия.
  final int count;

  /// Тип действия.
  final PendingType type;

  @override
  List<Object?> get props => [productId, count, type];
}

enum PendingType {
  product,
  clear,
  clearOutOfStock,
  tares,
  // TODO(kvbykov): уже сделано костылями, но лучше по-хорошему потом сделать.
  // bonuses,
  // promocode,
}
