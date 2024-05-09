import 'package:niagara_app/features/profile/bonuses/domain/models/bonuses.dart';

final mock = [
  Bonus(
    programId: 'Списание за покупку',
    isTemp: false,
    endDate: DateTime.fromMillisecondsSinceEpoch(1708758000 * 1000),
    count: -254,
  ),
  Bonus(
    programId: 'Начисление за покупку',
    isTemp: false,
    endDate: DateTime.fromMillisecondsSinceEpoch(1708414200 * 1000),
    count: 54,
  ),
  Bonus(
    programId: 'Начисление за акцию',
    isTemp: false,
    endDate: DateTime.fromMillisecondsSinceEpoch(1708327800 * 1000),
    count: 100,
  ),
  Bonus(
    programId: 'Сгорание временных бонусов',
    isTemp: false,
    endDate: DateTime.fromMillisecondsSinceEpoch(1708758000 * 1000),
    count: -50,
  ),
  Bonus(
    programId: 'Временные бонусы',
    isTemp: true,
    endDate: DateTime.fromMillisecondsSinceEpoch(1708414200 * 1000),
    count: 100,
  ),
  Bonus(
    programId: 'Временные бонусы',
    isTemp: true,
    endDate: DateTime.fromMillisecondsSinceEpoch(1708327800 * 1000),
    count: 50,
  ),
  Bonus(
    programId: 'Реферальный бонус',
    isTemp: false,
    endDate: DateTime.fromMillisecondsSinceEpoch(1708327800 * 1000),
    count: 100,
  ),
  Bonus(
    programId: 'Приветственный бонус',
    isTemp: false,
    endDate: DateTime.fromMillisecondsSinceEpoch(1708327800 * 1000),
    count: 100,
  ),
];
