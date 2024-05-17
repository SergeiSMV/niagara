import 'package:json_annotation/json_annotation.dart';
import 'package:niagara_app/core/core.dart';

part 'faq_bonuses_dto.g.dart';

@JsonSerializable(createToJson: false)
class FaqBonusesDto extends Equatable {
  const FaqBonusesDto({
    required this.question,
    required this.answer,
  });
  @JsonKey(name: 'question')
  final String question;
  @JsonKey(name: 'answer')
  final String answer;

  factory FaqBonusesDto.fromJson(Map<String, dynamic> json) =>
      _$FaqBonusesDtoFromJson(json);

  @override
  List<Object?> get props => [question, answer];
}
