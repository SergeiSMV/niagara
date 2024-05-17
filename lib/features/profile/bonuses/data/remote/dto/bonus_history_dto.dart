import 'package:json_annotation/json_annotation.dart';
import 'package:niagara_app/core/core.dart';

part 'bonus_history_dto.g.dart';

@Equatable()
@JsonSerializable(createToJson: false)
class BonusHistoryDto {
  BonusHistoryDto({
    required this.date,
    required this.value,
    required this.info,
    required this.isTemp,
  });

  @JsonKey(name: 'DATE')
  final String date;

  @JsonKey(name: 'VALUE')
  final int value;

  @JsonKey(name: 'INFO')
  final String info;

  @JsonKey(name: 'ISTEMP')
  final bool isTemp;

  factory BonusHistoryDto.fromJson(Map<String, dynamic> json) =>
      _$BonusHistoryDtoFromJson(json);
}
