import 'package:json_annotation/json_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/status_level_type.dart';

part 'bonuses_entity.g.dart';

class BonusesEntity extends Equatable {
  const BonusesEntity({
    required this.id,
    required this.cardNumber,
    required this.count,
    required this.tempCount,
    required this.tempLastDate,
    required this.tempDays,
    required this.level,
    required this.nextLevel,
    required this.endDate,
    required this.revThisMonth,
    required this.bottles,
  });

  final int id;
  final String cardNumber;
  final int count;
  final int tempCount;
  final String tempLastDate;
  final int tempDays;
  final StatusLevel level;
  final StatusLevel nextLevel;
  final DateTime endDate;
  final int revThisMonth;
  final BottlesEntity bottles;

  @override
  List<Object> get props => [
        id,
        cardNumber,
        count,
        tempCount,
        tempLastDate,
        tempDays,
        level,
        nextLevel,
        endDate,
        revThisMonth,
        bottles,
      ];
}

@JsonSerializable()
class BottlesEntity extends Equatable {
  const BottlesEntity({
    required this.count,
    required this.bottles,
  });

  final int count;
  final List<BottleEntity> bottles;

  factory BottlesEntity.fromJson(Map<String, dynamic> json) =>
      _$BottlesEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BottlesEntityToJson(this);

  @override
  List<Object?> get props => [
        count,
        bottles,
      ];
}

@JsonSerializable()
class BottleEntity extends Equatable {
  const BottleEntity({
    required this.productId,
    required this.name,
    required this.count,
    required this.offersId,
  });

  final String productId;
  final String name;
  final int count;
  final String offersId;

  factory BottleEntity.fromJson(Map<String, dynamic> json) =>
      _$BottleEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BottleEntityToJson(this);

  @override
  List<Object?> get props => [
        productId,
        name,
        count,
        offersId,
      ];
}
