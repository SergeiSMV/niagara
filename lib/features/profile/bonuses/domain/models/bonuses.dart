import 'package:intl/intl.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/status_level_type.dart';

/// Модель с полной информацией об уровне бонусной программы, VIP-статусе и
/// предоплатной воде пользователя.
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

  /// `ID` бонусного уровня (ассоциирован с ID пользователя)
  final int id;

  /// Номер бонусной карты.
  final String cardNumber;

  /// Количество бонусов.
  final int count;

  /// Количество временных бонусов.
  final int tempCount;

  /// Дата, до которой действуют временные бонусы.
  final String tempLastDate;

  /// Количество дней, которые будут действовать временные бонусы.
  final int tempDays;

  /// Уровень бонусной программы.
  final StatusLevel level;

  /// Следующий уровень бонусной программы.
  final StatusLevel nextLevel;

  /// Дата окончания действия бонусного уровня.
  final DateTime endDate;

  /// Сумма покупок за текущий месяц.
  final int revThisMonth;

  /// Предоплатная вода.
  final Bottles bottles;

  /// Форматированная дата окончания действия бонусного уровня.
  String get endDateFormated => DateFormat('dd.MM.yyyy').format(endDate);

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

/// Предоплатная вода.
class Bottles extends Equatable {
  const Bottles({
    required this.count,
    required this.bottles,
  });

  /// Количество бутылок.
  final int count;

  /// Массив товарных позиций предоплатной воды на счете.
  final List<Product> bottles;

  @override
  List<Object?> get props => [count, bottles];
}
