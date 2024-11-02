// ignore_for_file: sort_constructors_first

import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/promotions/domain/models/promotion.dart';

class Group extends Equatable {
  const Group({
    required this.name,
    required this.id,
    required this.image,
    this.temporary = false,
    this.promotionId,
  });

  final String name;
  final String id;
  final String image;

  /// Идентификатор акции, на основе которой была сконструирована данная группа.
  final String? promotionId;

  /// Индикатор того, что данная группа - временная и сконструирована на основе
  /// подборки акционных товаров.
  final bool temporary;

  /// Конструирует группу (если это возможно) по информации из акции, с которой
  /// эта группа будет связана.
  static Group? fromPromotion(Promotion promotion) => promotion.groupId != null
      ? Group(
          name: promotion.title,
          id: promotion.groupId!,
          image: promotion.image,
          temporary: true,
          promotionId: promotion.id,
        )
      : null;

  /// Конструирует группу с акционными товарами для категории предоплатной воды.
  static Group? forWater(String? bottlesGroupId) => bottlesGroupId != null
      ? Group(
          name: t.prepaidWater.title,
          image: '',
          id: bottlesGroupId,
          promotionId: 'water',
        )
      : null;

  @override
  List<Object?> get props => [name, id, image];
}
