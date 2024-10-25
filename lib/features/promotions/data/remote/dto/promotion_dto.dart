// ignore_for_file: sort_constructors_first

import 'package:niagara_app/core/core.dart';


class PromotionDto extends Equatable {
  const PromotionDto({
    this.id,
    this.name,
    this.description,
    this.image,
    this.dateBegin,
    this.dateEnd,
    this.personal,
    this.groupId,
  });

  final String? id;
  final String? name;
  final String? description;
  final String? image;
  final String? dateBegin;
  final String? dateEnd;
  final bool? personal;
  final String? groupId;

  factory PromotionDto.fromJson(Map<String, dynamic> json) => PromotionDto(
        id: json['ID'] as String?,
        name: json['NAME'] as String?,
        description: json['DESCRIPTION'] as String?,
        image: json['IMAGE'] as String?,
        dateBegin: json['DATE_BEGIN'] as String?,
        dateEnd: json['DATE_END'] as String?,
        personal: json['PERSONAL'] as bool?,
        groupId: json['PRODUCT_GROUP'] as String?,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        image,
        dateBegin,
        dateEnd,
        personal,
        groupId,
      ];
}
