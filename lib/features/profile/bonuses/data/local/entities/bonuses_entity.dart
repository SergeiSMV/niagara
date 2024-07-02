// ignore_for_file: sort_constructors_first

import 'package:json_annotation/json_annotation.dart';
import 'package:niagara_app/core/common/data/database/_imports.dart';
import 'package:niagara_app/core/core.dart';

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
  final List<ProductEntity> bottles;

  factory BottlesEntity.fromJson(Map<String, dynamic> json) =>
      _$BottlesEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BottlesEntityToJson(this);

  @override
  List<Object?> get props => [
        count,
        bottles,
      ];
}
