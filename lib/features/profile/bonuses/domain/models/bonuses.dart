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
  final List<Bonus> bonuses;
  // ? final List<dynamic> bottles;

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

class Bonus extends Equatable {
  const Bonus({
    required this.programId,
    required this.isTemp,
    required this.endDate,
    required this.count,
  });

  final String programId;
  final bool isTemp;
  final DateTime endDate;
  final int count;

  @override
  List<Object?> get props => [
        programId,
        isTemp,
        endDate,
        count,
      ];
}
