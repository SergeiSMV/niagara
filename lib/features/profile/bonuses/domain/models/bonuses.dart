import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/status_level_type.dart';

class Bonuses extends Equatable {
  const Bonuses({
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
  final Bottles bottles;

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

class Bottles extends Equatable {
  const Bottles({
    required this.count,
    required this.bottles,
  });

  final int count;
  final List<Bottle> bottles;

  @override
  List<Object?> get props => [count, bottles];
}

class Bottle extends Equatable {
  const Bottle({
    required this.id,
    required this.name,
    required this.count,
    required this.offersId,
  });

  final String id;
  final String name;
  final int count;
  final String offersId;

  @override
  List<Object?> get props => [id, name, count, offersId];
}
