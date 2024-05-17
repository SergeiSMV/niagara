import 'package:niagara_app/features/profile/bonuses/data/remote/dto/bonus_history_dto.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/bonus_history.dart';

extension BonusHistoryMapper on BonusHistoryDto {
  BonusHistory toModel() => BonusHistory(
        date: DateTime.parse(date),
        value: value,
        info: info,
        isTemp: isTemp,
      );
}
