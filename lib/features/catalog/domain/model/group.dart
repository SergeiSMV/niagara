// ignore_for_file: sort_constructors_first

import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/promotions/domain/models/promotion.dart';

class Group extends Equatable {
  const Group({
    required this.name,
    required this.id,
    required this.image,
    this.temporary = false,
  });

  final String name;
  final String id;
  final String image;

  /// Индикатор того, что данная группа - временная и сконструирована на основе
  /// подборки акционных товаров.
  final bool temporary;

  static Group? fromPromotion(Promotion promotion) => promotion.groupId != null
      ? Group(
          name: promotion.title,
          id: promotion.groupId!,
          image: promotion.image,
          temporary: true,
        )
      : null;

  @override
  List<Object?> get props => [name, id, image];
}
