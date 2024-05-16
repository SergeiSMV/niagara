// ignore_for_file: sort_constructors_first

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
    required this.bonuses,
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
  final List<BonusEntity> bonuses;

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
        bonuses,
      ];
}

@JsonSerializable()
class BonusEntity extends Equatable {
  const BonusEntity({
    required this.programId,
    required this.isTemp,
    required this.endDate,
    required this.count,
  });

  final String programId;
  final bool isTemp;
  final DateTime endDate;
  final int count;

  factory BonusEntity.fromJson(Map<String, dynamic> json) =>
      _$BonusEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BonusEntityToJson(this);

  @override
  List<Object?> get props => [
        programId,
        isTemp,
        endDate,
        count,
      ];
}
